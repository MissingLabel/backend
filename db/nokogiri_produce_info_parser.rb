require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'debugger'

class Produce
  attr_reader :how_to_select, :how_to_store, :uri

  def initialize(url)
    unless url.include?(' ' || ")" || "(" || "/")
      @uri = URI(url)
      @how_to_select = get_how_to_select_info
      @how_to_store = get_how_to_store_info
    end
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

  def get_produce_info
    page = fetch
    if page != nil
      if page.search('td')[11] != nil
        page.search('td')[11].text
      else
        return nil
      end
    end
  end

  def get_how_to_select_info
    unless get_produce_info == nil
      string = get_produce_info.gsub(/\s+/m, ' ').chomp
      select_info = string.scan(/How To Select.*How To Store/i)[0]
      no_select = select_info.sub(/How To Select/i, '')
      no_store = no_select.sub(/How To Store/i, '')
    end
  end

  def get_how_to_store_info
    unless get_produce_info == nil
      string = get_produce_info.gsub(/\s+/m, ' ').chomp
      store_info = string.scan(/How To Store.*Nutrition Benefits/i)[0]
      no_store = store_info.sub(/How To Store/i, '')
      no_store.sub(/Nutrition Benefits/i, '')
    end
  end

end



