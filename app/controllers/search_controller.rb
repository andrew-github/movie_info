class SearchController < ApplicationController
  def index
  end

  def results
    @movies = TmdbMovie.find( :title => params[:s].to_s, :expand_results => false ) or
      raise "Troubles with connecting to themoviedb.org"
  end

  def movie
    @movie = TmdbMovie.find( :id => params[:id].to_i ) or
      raise "Troubles with connecting to themoviedb.org"
    @actors = []
    @movie.cast.each do |cast|
      @actors << cast.name if cast.job == 'Actor'
      @director = cast.name if cast.job == 'Director'
    end
    results = GooglePlayScraper.parse( @movie.original_name, @movie.released ) or
      raise "Troubles with connecting to Google Play"
    @google_play_data =
      results[:href] == GooglePlayScraper::NOT_AVAILABLE ? GooglePlayScraper::NOT_AVAILABLE : view_context.link_to( results[:price], results[:href], :class => 'link' )
  end
end
