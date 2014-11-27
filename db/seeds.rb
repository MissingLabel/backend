# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require_relative "plu_parcer"

parce_plu_excel

banana = ProduceByPlu.find_by(plu_number: 4011)
banana.ndb_no = "09040"
banana.save

galaapple = ProduceByPlu.find_by(plu_number: 4135)
galaapple.ndb_no = "09503"
galaapple.save

navalorange = ProduceByPlu.find_by(plu_number: 3107)
navalorange.ndb_no = "09202"
navalorange.save