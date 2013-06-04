require 'spec_helper'

describe "GooglePlayScraper" do
  describe "self.parse" do
    it "returns a hash with :href and :price keys and string values" do
      result = GooglePlayScraper.parse( 'Iron Man', '2012-04-12' )
      result.should have_key(:href)
      result.should have_key(:price)
      result[:href].should be_an_instance_of(String)
      result[:price].should be_an_instance_of(String)
    end
  end

end
