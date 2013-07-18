class HomeController < ApplicationController
  def index
  end

  def search
#    binding.pry
    @fdic_search = FdicSearch.search_for(params[:last_name])
    @pbgc_search = PbgcSearch.search_for(params[:last_name], {:page => params[:page] || 1})
    @hud_search = HudSearch.search_for(params[:last_name])
    @has_results = true if @fdic_search[:total] > 0 or @pbgc_search[:total] > 0 or @hud_search[:total] > 0
  end
end
