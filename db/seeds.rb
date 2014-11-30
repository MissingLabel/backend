require_relative "plu_parcer"
require_relative "nokogiri_produce_info_parser"
require_relative "nokogiri_seasons_parser"
# require 'debugger'

# --- Seeds ProduceByPlu with commodity, variet, size --- #
parce_plu_excel

# --- Seeds seasons --- #

winter = Season.create!(name: "Winter")
spring = Season.create!(name: "Spring")
summer = Season.create!(name: "Summer")
fall = Season.create!(name: "Fall")

# --- Seeds seasons for berries --- #

berries = []

ProduceByPlu.all.each do |produce|
  if produce.commodity == "berries"
    berries << produce.variety
  end
end

berries.each do |berry|
  p berry
  winter_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-winter")
  if winter_list.list.include?(berry)
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |item|
      item.seasons << winter
    end
  end
  spring_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-spring")
  if spring_list.list.include?(berry)
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |item|
      item.seasons << spring
    end
  end
  summer_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-summer")
  if summer_list.list.include?(berry)
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |item|
      item.seasons << summer
    end
  end
  fall_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-fall")
  if fall_list.list.include?(berry)
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |item|
      item.seasons << fall
    end
  end
end

# --- Seeds seasons for all commodities --- #

commodities = []

ProduceByPlu.all.each do |produce|
  if produce.commodity != "berries" || produce.commodity != "melon" || produce.commodity != "apples" || produce.commodity != "bananas"
    commodities << produce.commodity
  end
end

commodities.each do |commodity|
  p commodity
  winter_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-winter")
  if winter_list.list.include?(commodity)
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |item|
      item.seasons << winter
    end
  end
  spring_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-spring")
  if spring_list.list.include?(commodity)
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |item|
      item.seasons << spring
    end
  end
  summer_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-summer")
  if summer_list.list.include?(commodity)
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |item|
      item.seasons << summer
    end
  end
  fall_list = Seasonal_list.new("http://www.fruitsandveggiesmorematters.org/whats-in-season-fall")
  if fall_list.list.include?(commodity)
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |item|
      item.seasons << fall
    end
  end
end

# --- Non-berries: Seeds how_to_select and how_to_store  --- #


def commodity_update
  produce = ProduceByPlu.where(commodity: "#{commodity}")
  produce.each do |produce|
    produce.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
  end
end

commodities.each do |commodity|
  p counter
  if Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}")
  elsif Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}-nutrition-selection-storage").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}-nutrition-selection-storage")
    commodity_update
  else
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: "Not available", how_to_store: "Not available")
    end
  end
end

# --- Apples --- #

def apples_update
  all_apples = ProduceByPlu.where(commodity: "apples")
  all_apples.each do |apple|
    apple.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
  end
end

if Produce.new("http://www.fruitsandveggiesmorematters.org/apple").how_to_select != nil
  new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/apple")
  apples_update
else  Produce.new("http://www.fruitsandveggiesmorematters.org/apple-nutrition-selection-storage").how_to_select != nil
  new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/apple-nutrition-selection-storage")
  apples_update
end

# --- Bananas --- #

def bananas_update
  all_bananas = ProduceByPlu.where(commodity: "bananas")
  all_bananas.each do |banana|
    banana.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
  end
end

if Produce.new("http://www.fruitsandveggiesmorematters.org/banana").how_to_select != nil
  new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/banana")
  bananas_update
elsif  Produce.new("http://www.fruitsandveggiesmorematters.org/banana-nutrition-selection-storage").how_to_select != nil
  new_produce = new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/banana-nutrition-selection-storage")
  bananas_update
end

# --- Melons --- #

melons = []

ProduceByPlu.all.each do |produce|
  if produce.commodity == "melon"
    melons << produce.variety
  end
end

def melon_update
  produce = ProduceByPlu.where(variety: "#{melon}")
  produce.each do |produce|
    produce.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
  end
end

melons.each do |melon|
  if Produce.new("http://www.fruitsandveggiesmorematters.org/#{melon}").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{melon}")
    melon_update
  elsif Produce.new("http://www.fruitsandveggiesmorematters.org/#{melon}-nutrition-selection-storage").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{melon}-nutrition-selection-storage")
    melon_update
    end
  else
    produce = ProduceByPlu.where(variety: "#{melon}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: "Not available", how_to_store: "Not available")
    end
  end
end

# --- Berries: Seeds how_to_select and how_to_store --- #

def berries_update
  produce = ProduceByPlu.where(variety: "#{berry}")
  produce.each do |produce|
    produce.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
  end
end

berries.each do |berry|
  if Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}")
    berries_update
  elsif Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}-nutrition-selection-storage").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}-nutrition-selection-storage")
    berries_update
    end
  else
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: "Not available", how_to_store: "Not available")
    end
  end
end


#ndb seed ---------------------------------------

# ProduceByPlu.all.each do |food|
#   new_produce = ProduceNdb.new("http://www.thefruitpages.com/chart#{food.commodity.split(" ")[0]}.shtml")


#   produce = ProduceByPlu.where(commodity: food.commodity)
#   produce.each do |produce|
#     produce.update_attributes(ndb_no: new_produce.ndb_no)
#   end
# end

# berries.each do |berry|
#   new_produce = ProduceNdb.new("http://www.thefruitpages.com/chart#{berry.split(" ")[0]}.shtml")
#    produce = ProduceByPlu.where(variety: berry)

#   produce.each do |produce|
#     produce.update_attributes(ndb_no: new_produce.ndb_no)
#   end
# end

#------------------------------------------------



