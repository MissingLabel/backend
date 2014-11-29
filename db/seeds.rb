require_relative "plu_parcer"
require_relative "nokogiri_produce_info_parser"
require 'debugger'

parce and seeds plu commodity, variet, size etc
parce_plu_excel

# seeds ndb_no according to PLU number
banana = ProduceByPlu.find_by(plu_number: 4011)
banana.ndb_no = "09040"
banana.save

galaapple = ProduceByPlu.find_by(plu_number: 4135)
galaapple.ndb_no = "09503"
galaapple.save

navalorange = ProduceByPlu.find_by(plu_number: 3107)
navalorange.ndb_no = "09202"
navalorange.save

# --- Non-berries: Seeds how_to_select and how_to_store  --- #

commodities = []

ProduceByPlu.all.each do |produce|
  if produce.commodity != "berries"
    commodities << produce.commodity
  end
end

commodities.each do |commodity|
  counter = 0
  p counter
  if Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}")
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
      counter += 1
    end
  elsif Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}-nutrition-selection-storage").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{commodity}-nutrition-selection-storage")
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
       counter += 1
    end
  else
    produce = ProduceByPlu.where(commodity: "#{commodity}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: "Not available", how_to_store: "Not available")
       counter += 1
    end
  end
end

# --- Berries: Seeds how_to_select and how_to_store --- #

berries = []

ProduceByPlu.all.each do |produce|
  if produce.commodity == "berries"
    berries << produce.variety
  end
end

berries.each do |berry|
  counter = 0
  if Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}")
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
    end
  elsif Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}-nutrition-selection-storage").how_to_select != nil
    new_produce = Produce.new("http://www.fruitsandveggiesmorematters.org/#{berry}-nutrition-selection-storage")
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: new_produce.how_to_select, how_to_store: new_produce.how_to_store)
    end
  else
    produce = ProduceByPlu.where(variety: "#{berry}")
    produce.each do |produce|
      produce.update_attributes(how_to_select: "Not available", how_to_store: "Not available")
    end
  end
end

#ndb seed ---------------------------------------

ProduceByPlu.all.each do |food|
  new_produce = ProduceNdb.new("http://www.thefruitpages.com/chart#{food.commodity.split(' ')[0]}.shtml")


  produce = ProduceByPlu.where(commodity: food.commodity)
  produce.each do |produce|
    produce.update_attributes(ndb_no: new_produce.ndb_no)
  end
end

#------------------------------------------------


