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

ActiveRecord::Schema.define(version: 20201201082023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "_WARNING", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.string "message"
  end

  create_table "adjustments", force: :cascade do |t|
    t.float "credit_amount"
    t.string "credit_note_num"
    t.date "credit_date"
    t.string "remark"
    t.integer "adjust_quantity"
    t.string "claim_product_type"
    t.integer "claim_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "actual_amount"
  end

  create_table "appointments", force: :cascade do |t|
    t.date "appoint_date"
    t.string "appoint_time"
    t.string "contacts_ids"
    t.string "appoint_note"
    t.integer "app_contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "app_contact_type"
    t.string "mail_status"
    t.integer "supplier_id"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "cfa_titles", force: :cascade do |t|
    t.string "job_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "claim_issues", force: :cascade do |t|
    t.string "description"
    t.date "cut_off_date"
    t.string "status"
    t.string "notes"
    t.bigint "contact_id"
    t.bigint "appointment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approval"
    t.string "mail_status"
    t.string "remarks"
    t.string "manual_status"
    t.index ["appointment_id"], name: "index_claim_issues_on_appointment_id"
    t.index ["contact_id"], name: "index_claim_issues_on_contact_id"
  end

  create_table "claim_mails", force: :cascade do |t|
    t.string "email"
    t.string "claim_no"
    t.string "status"
    t.bigint "claim_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["claim_id"], name: "index_claim_mails_on_claim_id"
  end

  create_table "claim_syns", force: :cascade do |t|
    t.integer "p_code"
    t.string "describtion"
    t.string "packing"
    t.string "batch_desc"
    t.date "expiry_date"
    t.integer "quantity"
    t.date "bill_date"
    t.string "bill_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "claims", force: :cascade do |t|
    t.string "claim_no"
    t.string "type_of_claim"
    t.date "claim_date"
    t.string "product_code"
    t.date "expiry_date"
    t.integer "quantity"
    t.float "claim_amount"
    t.float "settled_amount"
    t.date "bill_date"
    t.string "bill_number"
    t.string "status"
    t.string "supplier_code"
    t.bigint "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["supplier_id"], name: "index_claims_on_supplier_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "phone_number"
    t.string "address"
    t.string "jobs_name_type"
    t.integer "jobs_name_id"
    t.string "sub_contact_type"
    t.integer "sub_contact_id"
    t.string "mail_allocation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "landline_number"
  end

  create_table "division_syns", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "phone_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "divisions", force: :cascade do |t|
    t.string "div_name"
    t.string "div_code"
    t.string "mfr_code"
    t.string "div_abb"
    t.string "address_one"
    t.string "address_two"
    t.string "address_three"
    t.string "city"
    t.string "state"
    t.string "country"
    t.bigint "manufacturer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "old_id"
    t.index ["manufacturer_id"], name: "index_divisions_on_manufacturer_id"
  end

  create_table "emails", force: :cascade do |t|
    t.string "from_mail"
    t.string "to_mail"
    t.string "subject"
    t.string "message"
    t.string "attachment"
    t.date "date"
    t.string "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "excess_stock_emails", force: :cascade do |t|
    t.string "product_code"
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "excess_stock_logs", force: :cascade do |t|
    t.string "unique_no"
    t.string "description"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "excess_stocks", force: :cascade do |t|
    t.string "product_code"
    t.string "product_name"
    t.string "pakage_information"
    t.string "unit_description"
    t.integer "quantity"
    t.integer "free_quantity"
    t.string "excess_stock"
    t.string "current_stock"
    t.float "mrp"
    t.string "supplier_code"
    t.string "division_code"
    t.string "status"
    t.float "csv_cost"
    t.string "csv_purchase"
    t.float "esv_cost"
    t.float "esv_purchase"
    t.bigint "supplier_id"
    t.bigint "product_id"
    t.bigint "division_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "batch_stock"
    t.string "total_stock"
    t.string "excess_no"
    t.string "batch_discription"
    t.datetime "expiry_date"
    t.index ["division_id"], name: "index_excess_stocks_on_division_id"
    t.index ["product_id"], name: "index_excess_stocks_on_product_id"
    t.index ["supplier_id"], name: "index_excess_stocks_on_supplier_id"
  end

  create_table "expiry_damage_emails", force: :cascade do |t|
    t.string "claim_no"
    t.date "claim_date"
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expiry_damage_logs", force: :cascade do |t|
    t.string "claim_no"
    t.string "description"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expiry_damages", force: :cascade do |t|
    t.string "supplier_code"
    t.string "claim_no"
    t.date "ack_date"
    t.string "courier_lr_number"
    t.date "courier_date"
    t.string "courier_weight"
    t.string "ref_no"
    t.string "product_code"
    t.string "item_desc"
    t.string "packing"
    t.string "quantity"
    t.string "free_quantity"
    t.string "batch_desc"
    t.date "expiry_date"
    t.float "mrp"
    t.float "rate"
    t.string "claim_amount"
    t.string "settled_amount"
    t.bigint "supplier_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gross_amount"
    t.string "gst_num"
    t.string "div_code"
    t.integer "amount_status"
    t.string "status"
    t.string "remarks"
    t.string "product_status"
    t.float "actual_amount"
    t.string "gst"
    t.string "adjustment_num"
    t.datetime "adjustment_date"
    t.string "ws_settle_amount"
    t.string "adjusted_quantity"
    t.string "rejected_quantity"
    t.string "claim_status"
  end

  create_table "free_discount_emails", force: :cascade do |t|
    t.string "claim_no"
    t.date "claim_date"
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "free_discount_logs", force: :cascade do |t|
    t.string "claim_no"
    t.string "description"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "free_discounts", force: :cascade do |t|
    t.string "claim_no"
    t.date "ack_date"
    t.string "supplier_code"
    t.string "customer_name"
    t.string "product_code"
    t.string "product_name"
    t.string "total_quantity"
    t.string "rate"
    t.string "overall_discount_percentage"
    t.string "overall_discount_amount"
    t.string "bill_number"
    t.date "bill_date"
    t.string "claim_amount"
    t.string "settled_amount"
    t.bigint "supplier_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gross_num"
    t.string "gst_num"
    t.string "div_code"
    t.integer "amount_status"
    t.string "status"
    t.string "remarks"
    t.string "packings"
    t.string "mrp"
    t.string "free_quantity"
    t.float "actual_amount"
    t.string "gst"
    t.string "adjustment_num"
    t.datetime "adjustment_date"
    t.string "ws_settle_amount"
    t.string "adjusted_quantity"
    t.string "rejected_quantity"
    t.string "claim_status"
    t.string "batch_desc"
  end

  create_table "goods_receipts", force: :cascade do |t|
    t.string "gr_no"
    t.date "gr_date"
    t.string "invoice_no"
    t.float "amount"
    t.integer "quantity"
    t.string "purchase_order_code"
    t.string "product_code"
    t.string "supplier_code"
    t.string "status"
    t.bigint "product_id"
    t.bigint "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goods_received_notes", force: :cascade do |t|
    t.string "grn_number"
    t.date "grn_date"
    t.string "invoice_number"
    t.date "invoice_date"
    t.string "quantity"
    t.string "free_qunatity"
    t.string "gross"
    t.string "tax"
    t.string "amount"
    t.string "product_code"
    t.string "product_name"
    t.string "supplier_code"
    t.string "supplier_name"
    t.string "batch_description"
    t.string "purchase_price"
    t.string "mrp"
    t.string "purchase_taxcode"
    t.string "remarks"
    t.string "supplier_gstnumber"
    t.string "status"
    t.bigint "product_id"
    t.bigint "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grn_logs", force: :cascade do |t|
    t.string "unique_no"
    t.string "description"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mail_configurations", force: :cascade do |t|
    t.string "from_mail"
    t.string "from_password"
    t.string "cc_mail"
    t.string "cc_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "log_mail"
  end

  create_table "manufacturer_syns", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "phone_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "manufacturer_name"
    t.string "manufacturer_code"
    t.string "manufacturer_abb"
    t.string "address_one"
    t.string "addrsss_two"
    t.string "addrsss_three"
    t.string "city"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "old_id"
    t.bigint "supplier_id"
  end

  create_table "marketing_titles", force: :cascade do |t|
    t.string "job_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nagammai_connections", force: :cascade do |t|
    t.string "user_name"
    t.string "password"
    t.string "database_name"
    t.string "server_name"
    t.string "manual_sync_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "non_findable_claims", force: :cascade do |t|
    t.string "supplier_code"
    t.string "claim_no"
    t.date "ack_date"
    t.string "courier_lr_number"
    t.date "courier_date"
    t.string "courier_weight"
    t.string "ref_no"
    t.string "product_code"
    t.string "item_desc"
    t.string "packing"
    t.string "quantity"
    t.string "free_quantity"
    t.string "batch_desc"
    t.date "expiry_date"
    t.string "mrp"
    t.string "rate"
    t.string "claim_amount"
    t.string "settled_amount"
    t.string "status"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "adjusted_quantity"
    t.string "rejected_quantity"
    t.string "claim_status"
    t.bigint "supplier_id"
    t.bigint "product_id"
    t.string "gross_amount"
    t.string "gst_num"
    t.string "div_code"
    t.integer "amount_status"
    t.string "product_status"
    t.float "actual_amount"
    t.string "gst"
    t.string "adjustment_num"
    t.datetime "adjustment_date"
    t.string "ws_settle_amount"
  end

  create_table "non_findable_emails", force: :cascade do |t|
    t.string "claim_no"
    t.date "claim_date"
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "non_findable_logs", id: :serial, force: :cascade do |t|
    t.string "claim_no"
    t.string "description"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "non_moving_stocks", force: :cascade do |t|
    t.string "product_code"
    t.string "product_name"
    t.string "batch_description"
    t.date "received_date"
    t.date "last_sale_date"
    t.string "cost_val"
    t.string "invoice_number"
    t.string "supplier_code"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "batch_stock"
    t.string "total_stock"
    t.string "division_code"
    t.string "division_name"
    t.bigint "supplier_id"
    t.bigint "division_id"
    t.date "expiry_date"
    t.float "mrp"
    t.string "nm_no"
    t.string "packing"
  end

  create_table "nonmoving_stock_emails", id: :serial, force: :cascade do |t|
    t.string "product_code"
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nonmoving_stock_logs", force: :cascade do |t|
    t.string "unique_no"
    t.string "description"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_terms", force: :cascade do |t|
    t.string "job_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "po_emails", force: :cascade do |t|
    t.string "order_no"
    t.date "order_date"
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "claim_status"
  end

  create_table "po_logs", force: :cascade do |t|
    t.string "po_no"
    t.string "desc"
    t.string "reason"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "po_syns", force: :cascade do |t|
    t.integer "order_no"
    t.date "order_date"
    t.string "supplier_name"
    t.integer "total_item"
    t.integer "quantity"
    t.decimal "net_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pogr_emails", force: :cascade do |t|
    t.string "order_no"
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pogr_mismatches", force: :cascade do |t|
    t.string "po_number"
    t.string "gr_number"
    t.string "product_code"
    t.string "product_name"
    t.string "supplier_code"
    t.string "supplier_name"
    t.string "po_quantity"
    t.string "gr_quantity"
    t.string "excess_quantity"
    t.string "status"
    t.string "contact_ids"
    t.string "failed_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "supplier_id"
    t.bigint "product_id"
    t.string "grn_no_dummy"
    t.string "po_no_dummy"
  end

  create_table "pogr_syns", force: :cascade do |t|
    t.string "gr_no"
    t.date "date"
    t.string "invoice_no"
    t.string "supplier_name"
    t.decimal "gross_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.string "product_code"
    t.string "division_code"
    t.string "supplier_code"
    t.string "packing"
    t.string "hsn_code"
    t.string "gst_tax"
    t.float "purchase_price"
    t.float "sales_price"
    t.float "mrp"
    t.date "last_sale_date"
    t.date "last_receive_date"
    t.string "total_stock"
    t.bigint "division_id"
    t.bigint "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "old_id"
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.string "order_no"
    t.date "order_date"
    t.string "free_qty"
    t.string "quantity"
    t.string "amount"
    t.string "status"
    t.string "product_code"
    t.string "product_name"
    t.string "old_id"
    t.string "supplier_code"
    t.string "mfr_code"
    t.string "div_code"
    t.bigint "supplier_id"
    t.bigint "manufacturer_id"
    t.bigint "division_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "packings"
    t.string "dispatch_date"
    t.string "overall_note"
    t.string "gst"
    t.string "claim_status"
  end

  create_table "purchase_return_emails", force: :cascade do |t|
    t.string "claim_no"
    t.date "claim_date"
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchase_return_logs", force: :cascade do |t|
    t.string "claim_no"
    t.string "description"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchase_returns", force: :cascade do |t|
    t.string "claim_no"
    t.string "claim_date"
    t.string "product_code"
    t.string "item_description"
    t.string "supplier_code"
    t.string "quantity"
    t.string "free_quantity"
    t.string "batch"
    t.string "expiry_date"
    t.string "status"
    t.string "mrp"
    t.string "rate"
    t.string "remarks"
    t.string "claim_amount"
    t.string "settled_amount"
    t.bigint "supplier_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gross_amount"
    t.string "gst_num"
    t.string "div_code"
    t.integer "amount_status"
    t.string "courier_lr_number"
    t.string "courier_date"
    t.string "courier_weight"
    t.string "product_status"
    t.float "actual_amount"
    t.string "gst"
    t.string "adjustment_num"
    t.datetime "adjustment_date"
    t.string "ws_settle_amount"
    t.string "adjusted_quantity"
    t.string "rejected_quantity"
    t.string "claim_status"
  end

  create_table "rate_change_emails", force: :cascade do |t|
    t.string "claim_no"
    t.date "claim_date"
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rate_change_logs", force: :cascade do |t|
    t.string "claim_no"
    t.string "description"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rate_changes", force: :cascade do |t|
    t.string "claim_number"
    t.date "ack_date"
    t.string "supplier_code"
    t.string "div_code"
    t.string "product_code"
    t.string "product_name"
    t.string "quantity"
    t.string "batch"
    t.string "sales_price"
    t.string "rate"
    t.string "bill_number"
    t.date "bill_date"
    t.string "claim_amount"
    t.string "settled_amount"
    t.bigint "supplier_id"
    t.bigint "division_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "division_code"
    t.string "disc_amount"
    t.string "gross_amount"
    t.string "gst_num"
    t.integer "amount_status"
    t.string "status"
    t.string "remarks"
    t.float "actual_amount"
    t.string "gst"
    t.string "adjustment_num"
    t.datetime "adjustment_date"
    t.string "ws_settle_amount"
    t.string "adjusted_quantity"
    t.string "rejected_quantity"
    t.string "claim_status"
  end

  create_table "receive_mails", force: :cascade do |t|
    t.string "job_name"
    t.string "schedule"
    t.string "schedule_period"
    t.string "schedule_time"
    t.datetime "last_sync"
    t.string "path_setting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email1"
    t.string "password1"
    t.string "email2"
    t.string "password2"
    t.string "to_mail"
    t.string "log_mail"
    t.string "cc_mail"
  end

  create_table "report_details", force: :cascade do |t|
    t.string "purchase_order_count"
    t.string "purchase_order_reason"
    t.string "purchase_order_email_reason"
    t.string "expiry_broken_count"
    t.string "expiry_broken_reason"
    t.string "expiry_broken_email_reason"
    t.string "free_discount_count"
    t.string "free_discount_reason"
    t.string "free_discount_email_reason"
    t.string "purchase_return_count"
    t.string "purchase_return_reason"
    t.string "purchase_return_email_reason"
    t.string "rate_change_count"
    t.string "rate_change_reason"
    t.string "rate_change_email_reason"
    t.string "excess_stock_count"
    t.string "excess_stock_reason"
    t.string "excess_stock_email_reason"
    t.string "pogr_count"
    t.string "pogr_reason"
    t.string "pogr_email_reason"
    t.string "appointment_count"
    t.string "appointment_reason"
    t.string "appointment_email_reason"
    t.string "claim_issue_count"
    t.string "claim_issue_reason"
    t.string "claim_issue_email_reason"
    t.string "inbox_count"
    t.string "inbox_reason"
    t.string "inbox_email_reason"
    t.string "non_findable_claim_count"
    t.string "non_findable_claim_reason"
    t.string "non_findable_claim_email_reason"
    t.date "report_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "send_mails", force: :cascade do |t|
    t.string "job_name"
    t.string "schedule"
    t.string "schedule_period"
    t.string "schedule_time"
    t.string "send_items"
    t.datetime "last_sync"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settled_claims", force: :cascade do |t|
    t.string "settled_claim_no"
    t.string "claim_no"
    t.date "settled_date"
    t.integer "settled_qty"
    t.float "settled_amount"
    t.string "supplier_code"
    t.string "product_code"
    t.bigint "supplier_id"
    t.bigint "claim_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sops", force: :cascade do |t|
    t.string "order_type"
    t.string "payment_term"
    t.string "special_offer"
    t.string "claims_offer"
    t.string "expiry_broken_settlement"
    t.string "delivery_order_schedule"
    t.date "monthly_appoinment1"
    t.date "monthly_appoinment2"
    t.date "monthly_appoinment3"
    t.string "dispatch_mode"
    t.float "current_ns"
    t.float "current_ms"
    t.string "image"
    t.bigint "division_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "supplier_id"
    t.string "appoint_time1"
    t.string "appoint_time2"
    t.string "appoint_time3"
  end

  create_table "supplier_syns", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "phone_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "supplier_name"
    t.string "supplier_code"
    t.string "supplier_abb"
    t.string "address_one"
    t.string "addrsss_two"
    t.string "addrsss_three"
    t.string "gst_no"
    t.string "order_copy_format"
    t.string "phone_number"
    t.string "city"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "old_id"
    t.string "expiry_broken"
    t.string "batch"
    t.integer "active_status"
  end

  create_table "sync_settings", force: :cascade do |t|
    t.string "job_name"
    t.string "schedule"
    t.string "schedule_period"
    t.string "schedule_time"
    t.datetime "last_sync"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "additional1"
    t.string "additional2"
    t.string "additional3"
    t.date "last_modified_sync"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "password"
    t.string "email"
    t.string "role"
    t.string "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wonder_softs", force: :cascade do |t|
    t.string "user_name"
    t.string "password"
    t.string "database_name"
    t.string "server_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manual_sync_time"
  end

  add_foreign_key "appointments", "users"
  add_foreign_key "claim_issues", "appointments"
  add_foreign_key "claim_issues", "contacts"
  add_foreign_key "claim_mails", "claims"
  add_foreign_key "claims", "suppliers"
  add_foreign_key "divisions", "manufacturers"
  add_foreign_key "excess_stocks", "divisions"
  add_foreign_key "excess_stocks", "products"
  add_foreign_key "excess_stocks", "suppliers"
  add_foreign_key "expiry_damages", "products"
  add_foreign_key "expiry_damages", "suppliers"
  add_foreign_key "free_discounts", "products"
  add_foreign_key "free_discounts", "suppliers"
  add_foreign_key "goods_receipts", "products"
  add_foreign_key "goods_receipts", "suppliers"
  add_foreign_key "goods_received_notes", "products"
  add_foreign_key "goods_received_notes", "suppliers"
  add_foreign_key "manufacturers", "suppliers"
  add_foreign_key "non_moving_stocks", "products"
  add_foreign_key "pogr_mismatches", "products"
  add_foreign_key "pogr_mismatches", "suppliers"
  add_foreign_key "products", "divisions"
  add_foreign_key "products", "suppliers"
  add_foreign_key "purchase_orders", "divisions"
  add_foreign_key "purchase_orders", "manufacturers"
  add_foreign_key "purchase_orders", "products"
  add_foreign_key "purchase_orders", "suppliers"
  add_foreign_key "purchase_returns", "products"
  add_foreign_key "purchase_returns", "suppliers"
  add_foreign_key "rate_changes", "divisions"
  add_foreign_key "rate_changes", "products"
  add_foreign_key "rate_changes", "suppliers"
  add_foreign_key "settled_claims", "claims"
  add_foreign_key "settled_claims", "suppliers"
  add_foreign_key "claim_issues", "divisions"
  add_foreign_key "claim_issues", "users"
end
