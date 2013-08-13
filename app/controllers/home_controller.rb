class HomeController < ApplicationController
  before_filter :setup_session_user
  before_filter :merge_params_to_session, :except => [:logout]
  before_filter :setup_myusa_client, :except => [:logout]
  before_filter :setup_myusa_access_token, :except => [:logout]

  def search
    Headless.new.start if Rails.env == 'production'
    
    @fdic_search = FdicSearch.search_for(params[:last_name])
    @pbgc_search = PbgcSearch.search_for(params[:last_name], {:page => params[:page] || 1})
    @hud_search = HudSearch.search_for(params[:last_name])    
    @ca_search = CaUnclaimedProperty.new(params[:last_name]) if params[:states] && params[:states].include?('California')
    @md_search = MdUnclaimedProperty.new(params[:last_name]) if params[:states] && params[:states].include?('Maryland')
    
    @has_results = true if @fdic_search[:total] > 0 or 
                           @pbgc_search[:total] > 0 or 
                           @hud_search[:total] > 0 or 
                           @ca_search && @ca_search.total or 
                           @md_search && @md_search.total
  end

  def logout
    reset_session
    @myusa_access_token = nil

    redirect_to root_url
  end

  def oauth_callback
    auth = request.env["omniauth.auth"]
    session[:user] = auth.extra.raw_info.to_hash
    session[:token] = auth.credentials.token
    if request.env['action_dispatch.request.unsigned_session_cookie']['omniauth.origin']
      if request.env['omniauth.params']['modal']
        flash[request.env['omniauth.params']['modal']] = true
        flash[:success] = "You are now logged in to MyUSA and may add this item to your task list."
        redirect_to "#{request.env['action_dispatch.request.unsigned_session_cookie']['omniauth.origin']}##{request.env['omniauth.params']['modal']}"
      else
        redirect_to request.env['action_dispatch.request.unsigned_session_cookie']['omniauth.origin']
      end
    else
      redirect_to action:'index'
    end
  end

  def tasks
    if session[:user] != {} && @myusa_access_token
      tasks = create_tasks

      if tasks.status == 200
        flash[params[:modal]] = true
        flash[:success] = "Tasks saved to your MyUSA profile"
        back_to_search = "#{request.env['HTTP_REFERER']}##{params[:modal]}"
        redirect_to back_to_search
      else
        flash[:alert] = JSON.parse(response.body)["message"]
        redirect_to :back
      end
    else
      redirect_to "/auth/myusa?modal=#{params[:modal]}"
    end
  end
  
  private
  
  def setup_session_user
    session[:user] = {} if session[:user].nil?
  end
  
  def merge_params_to_session
    session.deep_merge!(params)
  end
  
  def setup_myusa_client
    @myusa_client = OAuth2::Client.new(MYUSA_CLIENT_ID, MYUSA_SECRET_ID, {:site => MYUSA_HOME, :token_url => "/oauth/authorize"})
  end

  def setup_myusa_access_token
    @myusa_access_token = OAuth2::AccessToken.new(@myusa_client, session[:token])
  end

  def create_tasks
    case params['task_type']
    when 'fdic'
      task_params = FdicSearch.build_tasks(params['uid'])
    when 'pbgc'
      task_params = PbgcSearch.build_tasks(params['url'])
    when 'hud'
      task_params = HudSearch.build_tasks(params['uid'])
    when 'ca'
      task_params = CaUnclaimedProperty.build_tasks(params['uid'], params['url'])
    when 'md'
      task_params = MdUnclaimedProperty.build_tasks(params['uid'])
    end
    
    tasks_response = @myusa_access_token.post("/api/tasks", task_params)
  end

end
