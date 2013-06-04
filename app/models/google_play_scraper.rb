class GooglePlayScraper
  require 'nokogiri'
  require 'open-uri'
  GOOGLE_PLAY_URL = 'http://proxy.arcticgames.net/proxy/index.php?____pgfa=aHR0cHM6Ly9wbGF5Lmdvb2dsZS5jb20vc3RvcmUvc2VhcmNo&q=placeholder&c=movies'
  NOT_AVAILABLE   = 'Not available'

  def self.parse( movie_name, released_year )
    year = released_year.nil? ? '':" #{released_year[0,4]}"
    url = GOOGLE_PLAY_URL.sub( 'placeholder', CGI.escape("#{movie_name}#{year}") )

    doc = Nokogiri::HTML( open url ) or raise "Troubles with internet connection to Google"

    href  = doc.at_css(".title:first-child").nil? ? nil:doc.at_css(".results-section .title")[:href]
    price = doc.at_css("span.buy-button-price:first-child").nil? ? nil:doc.at_css("span.buy-button-price").content
    {
      href:  href.nil?  ? NOT_AVAILABLE : href,
      price: price.nil? ? NOT_AVAILABLE : price
    }
  end
end
