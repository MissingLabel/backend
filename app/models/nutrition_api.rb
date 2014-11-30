require 'net/http'
require 'nokogiri'
#incomplete
class NutritionApi
  attr_reader :calories

  def initialize(ndb_no)
    @ndb_no = ndb_no
    # @produce = ProduceByPlu.find_by(ndb_no: ndb_no)
    # @produce = {commodity: "Apple", variety: "Gala"}
  end

  def call_usda_api
    url = URI.parse("http://api.data.gov/usda/ndb/reports/?ndbno=#{@ndb_no}&type=f&format=xml&api_key=T7Or56nDBNq3C6VdIJC47Sz1qxprwdyByquFaV4A")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    res.body
  end

  def nokogiri_api_request
    xml_doc  = Nokogiri::XML(call_usda_api)
    # @name = @produce.commodity
    # @variety = @produce.variety
    puts "should be calories _________________"
    @calories = xml_doc.css("#5").first['valueper100g']
    @total_fat = xml_doc.css("").first['valueper100g']
    @fat_units = xml_doc.css("").first['valueper100g']
    @fat_per =
    @carb = xml_doc.css("").first['valueper100g']
    @carb_per =
    @carb_unit = xml_doc.css("").first['valueper100g']
    @sodium = xml_doc.css("").first['valueper100g']
    @sodium_per =
    @sudium_units = xml_doc.css("").first['valueper100g']
    @fiber = xml_doc.css("").first['valueper100g']
    @fiber_per =
    @sugars = xml_doc.css("").first['valueper100g']
    @sugars_unit = xml_doc.css("").first['valueper100g']
    @protein = xml_doc.css("").first['valueper100g']
    @protein_per =
    @protein_units = xml_doc.css("").first['valueper100g']
    @lower_label_1
  end

  def prettify_api_info
  end

end
# "http://api.data.gov/usda/ndb/reports/?ndbno=09503&type=f&format=xml&api_key=T7Or56nDBNq3C6VdIJC47Sz1qxprwdyByquFaV4A"
test = NutritionApi.new("09503")

# test.call_usda_api
test.nokogiri_api_request

# jsonobject = {:name => 'Apple',
#               :variety => 'Honeycrisp',
#               :calories => '30',
#               :total_fat => '.12',
#               :fat_units => 'g',
#               :fat_per => '3',
#               :carb => '23',
#               :carb_per => '10',
#               :carb_unit => 'g',
#               :sodium => '234',
#               :sodium_per => '45',
#               :sodium_units => 'g',
#               :fiber => '10.3',
#               :fiber_per => '18',
#               :fiber_units => 'g',
#               :sugars => '43',
#               :sugars_unit => 'g',
#               :protein => '23',
#               :protein_per => '50',
#               :protein_units => 'g',
#               :lower_label => [{:units => 'mg', :name => 'Calcium', :num => '5', :per => '18'},
#                                {:units => 'mg', :name => 'Iron', :num => '76', :per => '3'},
#                                {:units => 'mg', :name => 'Potassium', :num => '45', :per => '12'},
#                                {:units => 'IU', :name => 'Vitamin A', :num => '.47', :per => '15'},
#                                {:units => 'µg', :name => 'Vitamin B-6', :num => '.19', :per => '9'}],
#               :organic => true,
#               :gmo => false,
#               :seasons => 'Fall, Spring',
#               :chemicals => true,
#               :farm_name => 'All Seasons Apple Orchard',
#               :farm_address => '14510 Route 176, Woodstock, IL',
#               :plu_no => '3283',
#               :how_pick => 'look for good ones',
#               :how_store => 'just keep it in the fridge or something'}