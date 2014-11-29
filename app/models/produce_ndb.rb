require 'nokogiri'
require 'open-uri'
require 'net/http'

class ProduceNdb
  attr_reader :ndb_no

  def initialize(url)
    @uri = URI(url)
    get_ndb_no
  end

  def page_check(response)
    if response.code == "404"
      return nil
    else
      page = Nokogiri::HTML(response.body)
      page
    end
  end

  def fetch
     Net::HTTP.start(@uri.host, @uri.port) do |http|
      request = Net::HTTP::Get.new(@uri, {'User-Agent' => 'Chrome 41.0.2228.0'})
      response = http.request request # Net::HTTPResponse object

      page_check(response)
    end
  end

  def get_ndb_no
    page = fetch

    if page != nil
      @ndb_no = page.search('caption[3]').text.match(/\d+/)[0]
    end
  end
end

# produce = Produce_ndb.new("http://www.thefruitpages.com/chartapples.shtml")
# p produce.get_ndb_no
# produce.ndb_info