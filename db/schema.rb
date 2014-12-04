# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141130020945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "produce_by_gs1s", force: true do |t|
    t.string   "gs1_number"
    t.text     "pesticides_chemicals"
    t.integer  "produce_by_plu_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "produce_by_plus", force: true do |t|
    t.integer  "plu_number"
    t.string   "ndb_no"
    t.string   "commodity"
    t.string   "variety"
    t.string   "size"
    t.text     "how_to_store"
    t.text     "how_to_select"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasonal_fruits", force: true do |t|
    t.integer  "season_id"
    t.integer  "produce_by_plu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasons", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.integer  "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
