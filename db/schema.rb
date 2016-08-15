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

ActiveRecord::Schema.define(version: 20160814030426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "client_competitors", force: :cascade do |t|
    t.integer  "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "manufacturer_id"
    t.string   "title"
    t.string   "upc"
    t.integer  "weight"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "raw_products", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "url"
    t.decimal  "sale_price"
    t.decimal  "original_price"
    t.integer  "stock"
    t.string   "discount"
    t.boolean  "free_shipping",  default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "store_products", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "product_id"
    t.string   "url"
    t.decimal  "sale_price"
    t.decimal  "original_price"
    t.integer  "stock"
    t.string   "discount"
    t.boolean  "free_shipping",  default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "store_scrape_terms", force: :cascade do |t|
    t.integer  "competitor_id"
    t.string   "title"
    t.string   "sale_price"
    t.string   "original_price"
    t.string   "free_shipping"
    t.string   "stock"
    t.string   "discount"
    t.string   "option_title"
    t.string   "option_price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "home_url"
    t.string   "all_products_url"
    t.string   "ecomm_platform"
    t.hstore   "fuzzy_match_stop_words"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stores", ["fuzzy_match_stop_words"], name: "index_stores_on_fuzzy_match_stop_words", using: :btree

end
