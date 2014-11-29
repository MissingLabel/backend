# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require_relative "plu_parcer"
require_relative "nokogiri_produce_info_parser"

# parce and seeds plu commodity, variet, size etc
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

# --- seeds how_to_select and how_to_store for ProduceByPLU objects --- #

commodities = []

ProduceByPlu.all.each do |produce|
  if produce.commodity != "Berries"

    commodities << produce.commodity
  else
    commodities << produce.variety
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
