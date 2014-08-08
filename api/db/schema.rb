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

ActiveRecord::Schema.define(version: 20140808000039) do

  create_table "cards", force: true do |t|
    t.string   "name"
    t.string   "name_it"
    t.string   "number"
    t.integer  "set_id"
    t.string   "image_name"
    t.integer  "rarity"
    t.integer  "multiverse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cards", ["name", "set_id"], name: "index_cards_on_name_and_set_id"

  create_table "cards_collections", id: false, force: true do |t|
    t.integer "card_id"
    t.integer "collection_id"
  end

  add_index "cards_collections", ["collection_id"], name: "index_cards_collections_on_collection_id"

  create_table "collections", force: true do |t|
    t.string   "name"
    t.float    "value_min"
    t.float    "value_avg"
    t.float    "value_max"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["name"], name: "index_collections_on_name"

  create_table "sets", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sets", ["code"], name: "index_sets_on_code"

end
