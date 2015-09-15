ActiveRecord::Schema.define(version: 20150914195454) do

  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer  "quantity"
    t.decimal  "unit_price", precision: 8, scale: 2
    t.integer  "invoice_id"
    t.integer  "item_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "invoice_items", ["invoice_id"], name: "index_invoice_items_on_invoice_id", using: :btree
  add_index "invoice_items", ["item_id"], name: "index_invoice_items_on_item_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.string   "status"
    t.integer  "customer_id"
    t.integer  "merchant_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "invoices", ["customer_id"], name: "index_invoices_on_customer_id", using: :btree
  add_index "invoices", ["merchant_id"], name: "index_invoices_on_merchant_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "unit_price",  precision: 8, scale: 2
    t.integer  "merchant_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "items", ["merchant_id"], name: "index_items_on_merchant_id", using: :btree

  create_table "merchants", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "credit_card_number"
    t.string   "result"
    t.integer  "invoice_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "transactions", ["invoice_id"], name: "index_transactions_on_invoice_id", using: :btree

  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoice_items", "items"
  add_foreign_key "invoices", "customers"
  add_foreign_key "invoices", "merchants"
  add_foreign_key "items", "merchants"
  add_foreign_key "transactions", "invoices"
end
