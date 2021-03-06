require 'net/http'
require 'nokogiri'

class NutritionApi
  attr_reader :calories, :api_url
  attr_accessor :produce

  def initialize(ndb_no)
    @ndb_no = ndb_no
    @produce = ProduceByPlu.find_by(ndb_no: ndb_no)
  end

  def make_api_url
      api_url = "http://api.data.gov/usda/ndb/reports/?ndbno=#{@ndb_no}&type=f&format=xml&api_key=T7Or56nDBNq3C6VdIJC47Sz1qxprwdyByquFaV4A"
  end

  def call_usda_api
    url = URI.parse(make_api_url)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    res.body
  end

  def display_seasons
    seasons = []
    @produce.seasons.each do |season|
      seasons << season.name
    end
    seasons.uniq.join(", ")
  end

  def nokogiri_api_request
    xml_doc  = Nokogiri::XML(call_usda_api)
    @name = @produce.commodity
    @calories = xml_doc.css("#5").first['valueper100g']
    @total_fat = xml_doc.css("#2").first['valueper100g']
    @fat_units = xml_doc.css("#2").first['unit']
    @fat_per = ((@total_fat.to_f/65) * 100).round
    @carb = xml_doc.css("#3").first['valueper100g']
    @carb_per = ((@carb.to_f/325) * 100).round
    @carb_unit = xml_doc.css("#3").first['unit']
    @sodium = xml_doc.css("#26").first['valueper100g']
    @sodium_per = ((@sodium.to_f/2400) * 100).round
    @sudium_units = xml_doc.css("#26").first['unit']
    @fiber = xml_doc.css("#20").first['valueper100g']
    @fiber_per = ((@fiber.to_f/26) * 100).round
    @fiber_units = xml_doc.css("#20").first['unit']
    @sugars = xml_doc.css("#18").first['valueper100g']
    @sugars_unit = xml_doc.css("#18").first['unit']
    @protein_num = xml_doc.css("#1").first['valueper100g']
    @protein_per = ((@protein_num.to_f/175) * 100).round
    @protein_units = xml_doc.css("#1").first['unit']
    @calcium_num = xml_doc.css("#21").first['valueper100g']
    @calcium_units = xml_doc.css("#21").first['unit']
    @calcium_per = ((@calcium_num.to_f/1000) * 100).round
    @calcium_name = "Calcium"
    @iron_num = xml_doc.css("#22").first['valueper100g']
    @iron_units = xml_doc.css("#22").first['unit']
    @iron_per = ((@iron_num.to_f/18) * 100).round
    @iron_name = "Iron"
    @magnesium_num = xml_doc.css("#23").first['valueper100g']
    @magnesium_units = xml_doc.css("#23").first['unit']
    @magnesium_per = ((@magnesium_num.to_f/400) * 100).round
    @magnesium_name = "Magnesium"
    @potassium_num = xml_doc.css("#25").first['valueper100g']
    @potassium_units = xml_doc.css("#25").first['unit']
    @potassium_per = ((@potassium_num.to_f/3500) * 100).round
    @potassium_name = "Potassium"
    @zinc_num = xml_doc.css("#27").first['valueper100g']
    @zinc_units = xml_doc.css("#27").first['unit']
    @zinc_per = ((@zinc_num.to_f/15) * 100).round
    @zinc_name = "Zinc"
    @niacin_num = xml_doc.css("#55").first['valueper100g']
    @niacin_units = xml_doc.css("#55").first['unit']
    @niacin_per = ((@niacin_num.to_f/20) * 100).round
    @niacin_name = "Niacin"
    @b6_num = xml_doc.css("#57").first['valueper100g']
    @b6_units = xml_doc.css("#57").first['unit']
    @b6_per = ((@b6_num.to_f/2) * 100).round
    @b6_name = "Vitamin B-6"
    @a_num = xml_doc.css("#32").first['valueper100g']
    @a_units = xml_doc.css("#32").first['unit']
    @a_name = "Vitamin A"
    @a_per = ((@a_num.to_f/5000) * 100).round
  end

  def prettify_api_info
    nokogiri_api_request

            { :name => @produce.commodity,
              :variety => @produce.variety,
              :calories => @calories,
              :total_fat => @total_fat,
              :fat_units => @fat_units,
              :fat_per => @fat_per,
              :carb => @carb,
              :carb_per => @carb_per,
              :carb_unit => @carb_unit,
              :sodium => @sodium,
              :sodium_per => @sodium_per,
              :sodium_units => @sudium_units,
              :fiber => @fiber,
              :fiber_per => @fiber_per,
              :fiber_units => @fiber_units,
              :sugars => @sugars,
              :sugars_unit => @sugars_unit,
              :protein => @protein_num,
              :protein_per => @protein_per,
              :protein_units => @protein_units,
              :lower_label => [{:units => @calcium_units, :name => 'Calcium', :num => @calcium_num, :per => @calcium_per},
                               {:units => @iron_units, :name => 'Iron', :num => @iron_num, :per => @iron_per},
                               {:units => @magnesium_units, :name => @magnesium_name, :num => @magnesium_num, :per => @magnesium_per},
                               {:units => @potassium_units, :name => @potassium_name, :num => @potassium_num, :per => @potassium_per},
                               {:units => @a_units, :name => 'Vitamin A', :num => @a_num, :per => @a_per},
                               {:units => @zinc_units, :name => @zinc_name, :num => @zinc_num, :per => @zinc_per},
                               {:units => @niacin_units, :name => @niacin_name, :num => @niacin_num, :per => @niacin_per},
                               {:units => @b6_units, :name => 'Vitamin B-6', :num => @b6_num, :per => @b6_per}],
              :seasons => display_seasons,
              :plu_no => @produce.plu_number,
              :how_pick => @produce.how_to_select,
              :how_store => @produce.how_to_store}
  end

end
# "http://api.data.gov/usda/ndb/reports/?ndbno=09503&type=f&format=xml&api_key=T7Or56nDBNq3C6VdIJC47Sz1qxprwdyByquFaV4A"
# test = NutritionApi.new("09503")

# test.call_usda_api
# test.nokogiri_api_request

