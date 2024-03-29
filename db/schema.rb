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

ActiveRecord::Schema.define(version: 20160904093826) do

  create_table "combos", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "products",    limit: 255
    t.integer  "price",       limit: 4
    t.binary   "picture",     limit: 65535
    t.boolean  "hidden",                    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "orders", force: :cascade do |t|
    t.text     "cart",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.text     "customer",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "paid_at"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "cost",        limit: 4
    t.integer  "price",       limit: 4
    t.binary   "picture",     limit: 65535
    t.boolean  "hidden",                    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "delta",      limit: 4
    t.integer  "order_id",   limit: 4
    t.string   "remark",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stocks", ["order_id"], name: "index_stocks_on_order_id", using: :btree
  add_index "stocks", ["product_id"], name: "index_stocks_on_product_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.binary   "picture",         limit: 65535
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "is_admin",                      default: false, null: false
  end

  add_foreign_key "orders", "users"
  add_foreign_key "stocks", "orders"
  add_foreign_key "stocks", "products"
end
