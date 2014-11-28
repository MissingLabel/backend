require 'nokogiri'
require 'open-uri'


class Produce
  attr_reader :how_to_select, :how_to_store

  def initialize(url)
    @url = url
    @page = Nokogiri::HTML(open(@url))
    @how_to_select = get_how_to_select_info
    @how_to_store = get_how_to_store_info
  end

  def produce_info
    @page.search('td')[11].text
  end

  def get_how_to_select_info
    string = produce_info.gsub(/\s+/m, ' ').chomp
    select_info = string.scan(/How To Select.*How To Store/i)[0]
    no_select = select_info.sub(/How To Select/i, '')
    no_select.sub(/How To Store/i, '')
  end

  def get_how_to_store_info
    string = produce_info.gsub(/\s+/m, ' ').chomp
    store_info = string.scan(/How To Store.*Nutrition Benefits/i)[0]
    no_store = store_info.sub(/How To Store/i, '')
    no_store.sub(/Nutrition Benefits/i, '')
  end

end


