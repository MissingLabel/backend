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
    @total_fat = xml_doc.css("#2").first['valueper100g']
    @fat_units = xml_doc.css("").first['unit']
    @fat_per = (@total_fat.to_i/65)
    @carb = xml_doc.css("#3").first['valueper100g']
    @carb_per = (@carb.to_i/325)
    @carb_unit = xml_doc.css("#3").first['unit']
    @sodium = xml_doc.css("#26").first['valueper100g']
    @sodium_per = (@sodium.to_i/2400)
    @sudium_units = xml_doc.css("#26").first['unit']
    @fiber = xml_doc.css("#20").first['valueper100g']
    @fiber_per = (@fiber.to_i/26)
    @sugars = xml_doc.css("#18").first['valueper100g']
    @sugars_unit = xml_doc.css("#18").first['unit']
    @protein_num = xml_doc.css("#1").first['valueper100g']
    @protein_per = (@protein_num.to_i/175)
    @protein_units = xml_doc.css("#1").first['unit']
    @calcium_num = xml_doc.css("#21").first['valueper100g']
    @calcium_units = xml_doc.css("#21").first['unit']
    @calcium_per = (@calcium_num.to_i/1000)
    @calcium_name = "Calcium"
    @iron_num = xml_doc.css("#22").first['valueper100g']
    @iron_units = xml_doc.css("#22").first['unit']
    @iron_per = (@iron_num.to_i/18)
    @iron_name = "Iron"
    @magnesium_num = xml_doc.css("#23").first['valueper100g']
    @magnesium_units = xml_doc.css("#23").first['unit']
    @magnesium_per = (@magnesium_num.to_i/400)
    @magnesium_name = "Magnesium"
    @potassium_num = xml_doc.css("#25").first['valueper100g']
    @potassium_units = xml_doc.css("#25").first['unit']
    @potassium_per = (@potassium_num.to_i/3500)
    @potassium_name = "Potassium"
    @zinc_num = xml_doc.css("#27").first['valueper100g']
    @zinc_units = xml_doc.css("#27").first['unit']
    @zinc_per = (@zinc_num.to_i/15)
    @zinc_name = "Zinc"
    @niacin_num = xml_doc.css("#55").first['valueper100g']
    @niacin_units = xml_doc.css("#55").first['unit']
    @niacin_per = (@niacin_num.to_i/20)
    @niacin_name = "Niacin"
    @b6_num = xml_doc.css("#57").first['valueper100g']
    @b6_units = xml_doc.css("#57").first['unit']
    @b6_per = (@b6_num.to_i/2)
    @b6_name = "Vitamin B-6"
    @a_num = xml_doc.css("#32").first['valueper100g']
    @a_units = xml_doc.css("#32").first['unit']
    @a_per = (@a_num.to_i/5000)
    @a_name = "Vitamin A"
    @a_per
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