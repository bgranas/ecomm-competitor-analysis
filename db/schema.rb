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

ActiveRecord::Schema.define(version: 20160817020551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "client_competitors", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "competitor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "group_match_exculsions", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "match_exclusion_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historical_store_products", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "product_id"
    t.string   "url"
    t.string   "product_title"
    t.decimal  "sale_price"
    t.decimal  "original_price"
    t.integer  "stock"
    t.string   "discount"
    t.decimal  "shipping"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_exclusions", force: :cascade do |t|
    t.string   "term"
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
    t.string   "product_title"
    t.decimal  "sale_price"
    t.decimal  "original_price"
    t.integer  "stock"
    t.string   "discount"
    t.decimal  "shipping"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "store_all_products_urls", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "all_product_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "store_groups", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "store_products", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "product_id"
    t.string   "url"
    t.string   "product_title"
    t.decimal  "sale_price"
    t.decimal  "original_price"
    t.integer  "stock"
    t.string   "discount"
    t.decimal  "shipping"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "store_scrape_terms", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "all_products"
    t.string   "product_title"
    t.string   "sale_price"
    t.string   "original_price"
    t.string   "shipping"
    t.string   "stock"
    t.string   "discount"
    t.string   "option_container"
    t.string   "option_title"
    t.string   "option_price"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "home_url"
    t.string   "ecomm_platform"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
