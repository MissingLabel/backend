require 'open-uri'
require 'net/http'
require 'nokogiri'
# require 'debugger'

class Seasonal_list
  attr_reader :get_list_for_season, :format_list

  def initialize(url)
      @uri = URI(url)
      @seasonal_fruits_veggies = get_list_for_season
  end

  def page_check(response)
    if response.code == "200"
      page = Nokogiri::HTML(response.body)
    else
      return nil
    end
  end

  def fetch
    Net::HTTP.start(@uri.host, @uri.port) do |http|
      request = Net::HTTP::Get.new(@uri)
      response = http.request(request)

      page_check(response)
    end
  end

  def get_list_for_season
    page = fetch
    page.search('.entry a[href]').text
  end

  def list
    get_list_for_season.downcase
  end

end
