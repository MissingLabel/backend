require_relative "plu_parcer"
require_relative "nokogiri_produce_info_parser"
require_relative "nokogiri_seasons_parser"
# require 'debugger'

# --- Seeds ProduceByPlu with commodity, variet, size --- #

parce_plu_excel

# ndb seed ---------------------------------------

berries = []

ProduceByPlu.all.each do |produce|
  if produce.commodity == "berries"
    berries << produce.variety
  end
end

ProduceByPlu.all.each do |food|
  new_produce = ProduceNdb.new("http://www.thefruitpages.com/chart#{food.commodity.split(" ")[0]}.shtml")


  produce = ProduceByPlu.where(commodity: food.commodity)
  produce.each do |produce|
    produce.update_attributes(ndb_no: new_produce.ndb_no)
  end
end

berries.each do |berry|
  new_produce = ProduceNdb.new("http://www.thefruitpages.com/chart#{berry.split(" ")[0]}.shtml")
   produce = ProduceByPlu.where(variety: berry)

  produce.each do |produce|
    produce.update_attributes(ndb_no: new_produce.ndb_no)
  end
end

# ------------------------------------------------

# --- Location --- #


eggplants_farm = Location.create!(name: "Riverfront Berry Farm", address: "2799 N. 1700 East Rd. Martinton, IL 60951")
avocados_farm = Location.create!( name: "Old Magee Ranch", address: "Old Magee Ranch, Magee Road, Pala, CA")
pomegarantes_farm = Location.create!(name: "Homegrown Organic Farms", address: "Porterville, CA 93258")
oranges_farm = Location.create!(name: "Johnston Farms", address: "13031 East Packing House Road, Edison, CA 93220")
cantaloupes_farm = Location.create!(name: "Trumptington Estate Church Farm", address: "Maris Lane, Cambridge, Cambridgeshire, CB2 9LG")
pears_farm = Location.create!(name: "Evergreen Farm", address: "1023 Yardville Allentown Rd Hamilton Township, NJ 08620")
peppers_farm = Location.create!(name: "Village Farms", address: "195 International Parkway, Heathrow, Florida 32746")
tomatoes_farm = Location.create!(name: "Walkup Heritage Farm", address: "5215 N. Walkup RdCrystal Lake, IL 60012")
apples_farm = Location.create!(name: "All Seasons Apple Orchard", address: "14510 Route 176 WoodStock, IL 60098")


# --- ProduceByGs1 -- #

eggplants = ProduceByPlu.find_by(plu_number: "4599")
avocados = ProduceByPlu.find_by(plu_number: "4225")
pomegarantes = ProduceByPlu.find_by(plu_number: "3440")
oranges = ProduceByPlu.find_by(plu_number: "3107")
cantaloupes = ProduceByPlu.find_by(plu_number: "4050")
pears = ProduceByPlu.find_by(plu_number: "4409")
peppers = ProduceByPlu.find_by(plu_number: "4688")
tomatoes = ProduceByPlu.find_by(plu_number: "4664")
honeycrisp = ProduceByPlu.find_by(plu_number: "3283")


eggplants = ProduceByGs1.create!(produce_by_plu: eggplants, location: eggplants_farm, pesticides_chemicals: "true", gs1_number: "0100856122001872")
avocados = ProduceByGs1.create!(produce_by_plu: avocados, location: avocados_farm, pesticides_chemicals: "true" , gs1_number: "0107500326086922")
pomegarantes = ProduceByGs1.create!(produce_by_plu: pomegarantes, location: pomegarantes_farm, pesticides_chemicals: "", gs1_number: "0100824150049982")
oranges = ProduceByGs1.create!(produce_by_plu: oranges, location: oranges_farm, pesticides_chemicals: "false", gs1_number: "0100605049931072")
cantaloupes = ProduceByGs1.create!(produce_by_plu: cantaloupes, location: cantaloupes_farm, pesticides_chemicals:"false", gs1_number: "0100857537003505")
pears = ProduceByGs1.create!(produce_by_plu: pears, location: pears_farm, pesticides_chemicals:"true", gs1_number: "0100741839944096")
peppers = ProduceByGs1.create!(produce_by_plu: peppers, location: peppers_farm, pesticides_chemicals: "false", gs1_number: "0100856122001414")
tomatoes = ProduceByGs1.create!(produce_by_plu: tomatoes, location: tomatoes_farm, pesticides_chemicals:"false", gs1_number: "0107503006984006")
apples = ProduceByGs1.create!(produce_by_plu: honeycrisp, location: apples_farm, pesticides_chemicals: "true", gs1_number: "0100736264032838")

# --- User --- #

User.create!(email: "joe@gmail.com", password: "password", zip_code: 12345)

# --- Seeds seasons --- #

winter_1 = Season.create!(name: "Winter")
spring_2 = Season.create!(name: "Spring")
summer_3 = Season.create!(name: "Summer")
fall_4 = Season.create!(name: "Fall")

# --- Seeds seasons for berries --- #


berries.uniq!

berries.each do |berry|
  p berry
  winter_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-winter")
  if winter_list.list.include?(berry)
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |item|
      item.seasons << winter_1
    end
  end
  spring_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-spring")
  if spring_list.list.include?(berry)
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |item|
      item.seasons << spring_2
    end
  end
  summer_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-summer")
  if summer_list.list.include?(berry)
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |item|
      item.seasons << summer_3
    end
  end
  fall_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-fall")
  if fall_list.list.include?(berry)
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |item|
      item.seasons << fall_4
    end
  end
end

# --- Seeds seasons for all commodities --- #

commodities = []

ProduceByPlu.all.each do |produce|
  if produce.commodity != "berries" && produce.commodity != "melon"
    commodities << produce.commodity
  end
end

commodities.uniq!

commodities.each do |commodity|
  p commodity
  winter_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-winter")
  if winter_list.list.include?(commodity)
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |item|
      item.seasons << Season.find(1)
    end
  end
  spring_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-spring")
  if spring_list.list.include?(commodity)
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |item|
      item.seasons << Season.find(2)
    end
  end
  summer_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-summer")
  if summer_list.list.include?(commodity)
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |item|
      item.seasons << Season.find(3)
    end
  end
  fall_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-fall")
  if fall_list.list.include?(commodity)
    produce = ProduceByPlu.where(commodi ty: "#{commodity}")
    produce.each do |item|
      item.seasons << Season.find(4)
    end
  end
  all_year = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-all-year")
  if all_year.list.include?(commodity)
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |item|
      item.seasons << Season.all
    end
  end
end

# --- Pears --- #

pears = ProduceByPlu.where(commodity: "pears")
  pears.each do |pear|
    pear.seasons << Season.find(1)
    pear.seasons << Season.find(4)
  end

# --- Apples --- #

all_apples = ProduceByPlu.where(commodity: "apples")

if Produce.new("http://www.fruitsandveggiesmorematters.org/apple").how_to_select != nil
  new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/apple")
  all_apples.each do |apple|
    apple.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
  end
elsif  Produce.new("http://www.fruitsandveggiesmorematters.org/apple-nutrition-selection-storage").how_to_select != nil
  new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/apple-nutrition-selection-storage")
  all_apples.each do |apple|
    apple.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
  end
else
  all_apples.each do |apple|
    apple.update_attributes(how_to_select: "Not available", how_to_store: "Not available")
  end
end

# --- Bananas --- #

all_bananas = ProduceByPlu.where(commodity: "bananas")

if Produce.new("http://www.fruitsandveggiesmorematters.org/banana").how_to_select != nil
  new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/banana")
  all_bananas.each do |banana|
    banana.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
  end
elsif  Produce.new("http://www.fruitsandveggiesmorematters.org/banana-nutrition-selection-storage").how_to_select != nil
  new_produce = new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/banana-nutrition-selection-storage")
  all_bananas.each do |banana|
    banana.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
  end
else
  all_bananas.each do |banana|
    banana.update_attributes(how_to_select: "Not available", how_to_store: "Not available")
  end
end

# --- Oranges --- #

all_oranges = ProduceByPlu.where(commodity: "oranges")

if Produce.new("http://www.fruitsandveggiesmorematters.org/orange").how_to_select != nil
  new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/orange")
  all_oranges.each do |orange|
    orange.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
  end
elsif  Produce.new("http://www.fruitsandveggiesmorematters.org/orange-nutrition-selection-storage").how_to_select != nil
  new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/orange-nutrition-selection-storage")
  all_oranges.each do |orange|
    orange.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
  end
else
  all_oranges.each do |orange|
    orange.update_attributes(how_to_select: "Not available", how_to_store: "Not available")
  end
end

# --- Berries: Seeds how_to_select and how_to_store --- #

berries.each do |berry|
  p berry
  if Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}")
    all_berries = ProduceByPlu.where(variety: "#{berry}")
    all_berries.each do |berry|
      berry.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
    end
  elsif Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}-nutrition-selection-storage").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}-nutrition-selection-storage")
    all_berries = ProduceByPlu.where(variety: "#{berry}")
    all_berries.each do |berry|
      berry.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
    end
  else
    all_berries = ProduceByPlu.where(variety: "#{berry}")
    all_berries.each do |berry|
      berry.update_attributes(how_to_select: "Not available", how_to_store: "Not available")
    end
  end
end

# # --- Melons --- #

melons = []

ProduceByPlu.all.each do |produce|
  if produce.commodity == "melon"
    melons << produce.variety
  end
end

melons.each do |melon|
  p melon
  if Produce.new("http://www.fruitsandveggiesmorematters.org/#{melon}").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{melon}")
    produce = ProduceByPlu.where(variety: "#{melon}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
    end
  elsif Produce.new("http://www.fruitsandveggiesmorematters.org/#{melon}-nutrition-selection-storage").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{melon}-nutrition-selection-storage")
    produce = ProduceByPlu.where(variety: "#{melon}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
    end
  else
    produce = ProduceByPlu.where(variety: "#{melon}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: "Not available", how_to_store: "Not available")
    end
  end
end

# --- Non-berries: Seeds how_to_select and how_to_store  --- #

com = []

ProduceByPlu.all.each do |produce|
  if produce.commodity != "berries" && produce.commodity != "melon" && produce.commodity != "oranges" && produce.commodity != "apples" && produce.commodity != "bananas"
    com << produce.commodity
  end
end

com.uniq!

com.each do |commodity|
  p commodity
  if Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}")
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
    end
  elsif Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}-nutrition-selection-storage").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}-nutrition-selection-storage")
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
    end
  else
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: "Not available", how_to_store: "Not available")
    end
  end
end


