require 'spec_helper'

describe SearchController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'results'" do
    it "returns http success" do
      get 'results'
      response.should be_success
    end
  end

  describe "GET 'movie'" do
    it "returns http success" do
      get 'movie', {:id => '607'}
      response.should be_success
    end

    it "returns 'Not available' value for @google_play_data[:href]" do
      get 'movie', {:id => '607'}
      obj = GooglePlayScraper
      obj.stub(:parse) { {href: GooglePlayScraper::NOT_AVAILABLE, price: GooglePlayScraper::NOT_AVAILABLE} }
      google_play_data = begin
      results = GooglePlayScraper.parse( 'Iron Man', '2012-04-12' )
        if results[:href] == GooglePlayScraper::NOT_AVAILABLE
          GooglePlayScraper::NOT_AVAILABLE
        else
          view_context.link_to results[:price], results[:href], :class => 'link'
        end
      end
      google_play_data.should == GooglePlayScraper::NOT_AVAILABLE
    end
  end

end
