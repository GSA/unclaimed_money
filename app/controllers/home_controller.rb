class HomeController < ApplicationController
  def index
  end

  def search
    @fdic_search = FdicSearch.search_for(params[:last_name])
    @pbgc_search = PbgcSearch.search_for(params[:last_name], {:page => params[:page] || 1})
    @hud_search = HudSearch.search_for(params[:last_name])
    @ca_search = CaUnclaimedProperty.new(params[:last_name]) if params[:states] && params[:states].include?('California')
    @md_search = MdUnclaimedProperty.new(params[:last_name]) if params[:states] && params[:states].include?('Maryland')
    
    @has_results = true if @fdic_search[:total] > 0 or @pbgc_search[:total] > 0 or @hud_search[:total] > 0 or @ca_search && @ca_search.total or @md_search && @md_search.total
  end
end
