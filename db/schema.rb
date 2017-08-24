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

ActiveRecord::Schema.define(version: 20170824225333) do

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_groups_on_account_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "asin"
    t.integer "group_id"
    t.datetime "last_checked", default: "1970-01-01 00:00:00"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asin"], name: "index_products_on_asin"
    t.index ["group_id"], name: "index_products_on_group_id"
    t.index ["last_checked"], name: "index_products_on_last_checked"
  end

  create_table "snapshots", force: :cascade do |t|
    t.string "title"
    t.text "images"
    t.text "features"
    t.text "description"
    t.integer "reviews_count"
    t.integer "bsr"
    t.string "bsr_category"
    t.string "asin", null: false
    t.integer "price_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asin"], name: "index_snapshots_on_asin"
  end

end
