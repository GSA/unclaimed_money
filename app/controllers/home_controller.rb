class HomeController < ApplicationController
  def index
  end

  def search
  end
  
  def fdic_search
    @fdic_results = FdicSearch.search(params[:last_name])
    render :json => @fdic_results
  end
end
