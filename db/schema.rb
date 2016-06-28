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

ActiveRecord::Schema.define(version: 20160628160622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jk_photos", force: :cascade do |t|
    t.integer  "jk_product_id"
    t.string   "photo_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "jk_products", force: :cascade do |t|
    t.string   "url"
    t.string   "title"
    t.decimal  "price"
    t.text     "description"
    t.string   "model"
    t.string   "interior_dimension"
    t.string   "exterior_dimension"
    t.string   "max_temp"
    t.string   "volts"
    t.string   "amps"
    t.string   "watts"
    t.string   "plug"
    t.string   "breaker"
    t.string   "wire_gauge"
    t.integer  "prod_weight"
    t.integer  "ship_weight"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
