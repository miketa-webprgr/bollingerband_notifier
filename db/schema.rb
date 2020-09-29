# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_27_163210) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "symbol", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.float "sigma", default: 1.0, null: false
    t.integer "mv_period", default: 10, null: false
    t.boolean "activated", default: false, null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_notifications_on_company_id"
  end

  create_table "prices", force: :cascade do |t|
    t.datetime "date", null: false
    t.float "close", null: false
    t.float "high"
    t.float "low"
    t.integer "volume"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["close"], name: "index_prices_on_close"
    t.index ["company_id"], name: "index_prices_on_company_id"
    t.index ["date", "company_id"], name: "index_prices_on_date_and_company_id", unique: true
  end

  create_table "searches", force: :cascade do |t|
    t.float "sigma", default: 1.0, null: false
    t.integer "mv_period", default: 10, null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_searches_on_company_id"
  end

  add_foreign_key "notifications", "companies"
  add_foreign_key "prices", "companies"
  add_foreign_key "searches", "companies"
end
