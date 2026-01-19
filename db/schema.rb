# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_01_19_213401) do
  create_table "account_events", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "resource_type"
    t.integer "resource_id"
    t.string "topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_events_on_account_id"
    t.index ["resource_type", "resource_id"], name: "index_account_events_on_resource"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "password"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "firstname"
    t.string "lastname"
    t.date "date_of_birth"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_customers_on_account_id"
  end

  create_table "fulfillment_services", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "state"
    t.string "sales_contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fulfillments", force: :cascade do |t|
    t.integer "fulfillment_service_id", null: false
    t.string "status"
    t.string "tracking_number"
    t.datetime "shipping_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fulfillment_service_id"], name: "index_fulfillments_on_fulfillment_service_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "order_id", null: false
    t.string "reference"
    t.string "status"
    t.decimal "pretax_total_amount"
    t.decimal "total_amount"
    t.decimal "vat_amount"
    t.decimal "paid_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_invoices_on_order_id"
  end

  create_table "order_lines", force: :cascade do |t|
    t.integer "order_id"
    t.string "name"
    t.integer "quantity"
    t.decimal "vat_rate"
    t.decimal "vat_price"
    t.decimal "pretax_unit_price"
    t.decimal "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_lines_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "customer_id", null: false
    t.integer "fulfillment_id"
    t.string "reference"
    t.string "customer_firstname"
    t.string "customer_lastname"
    t.string "customer_address"
    t.string "account_firstname"
    t.string "account_lastname"
    t.string "account_address"
    t.string "status"
    t.datetime "ordered_at"
    t.datetime "cancelled_at"
    t.decimal "vat_price"
    t.decimal "pretax_total_price"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_orders_on_account_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["fulfillment_id"], name: "index_orders_on_fulfillment_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type"
    t.integer "item_id"
    t.string "action"
    t.string "column"
    t.string "value"
    t.string "value_changed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_versions_on_item"
  end

  add_foreign_key "account_events", "accounts"
  add_foreign_key "customers", "accounts"
  add_foreign_key "fulfillments", "fulfillment_services"
  add_foreign_key "invoices", "orders"
  add_foreign_key "order_lines", "orders"
  add_foreign_key "orders", "accounts"
  add_foreign_key "orders", "customers"
end
