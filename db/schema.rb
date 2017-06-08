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

ActiveRecord::Schema.define(version: 20170605061419) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",           limit: 50
    t.string   "email",          limit: 50
    t.string   "contact_number", limit: 20
    t.string   "domain",         limit: 50
    t.string   "address"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["contact_number"], name: "index_companies_on_contact_number", using: :btree
    t.index ["domain"], name: "index_companies_on_domain", using: :btree
    t.index ["email"], name: "index_companies_on_email", using: :btree
  end

  create_table "company_coupon_rules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_coupon_id"
    t.integer  "allowed_coupon"
    t.integer  "duration"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["company_coupon_id"], name: "index_company_coupon_rules_on_company_coupon_id", using: :btree
  end

  create_table "company_coupons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "number_of_coupon"
    t.integer  "company_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["company_id"], name: "index_company_coupons_on_company_id", using: :btree
    t.index ["number_of_coupon"], name: "index_company_coupons_on_number_of_coupon", using: :btree
  end

  create_table "coupons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code",        limit: 50
    t.datetime "expiry_date"
    t.string   "description"
    t.string   "vendor",      limit: 100
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["code"], name: "index_coupons_on_code", using: :btree
    t.index ["expiry_date"], name: "index_coupons_on_expiry_date", using: :btree
    t.index ["vendor"], name: "index_coupons_on_vendor", using: :btree
  end

  create_table "emails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",      limit: 50
    t.datetime "send_date"
    t.string   "otp",        limit: 4
    t.boolean  "verified",              default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "employee_coupons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "coupon_id"
    t.integer  "employee_id"
    t.integer  "company_coupon_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["company_coupon_id"], name: "index_employee_coupons_on_company_coupon_id", using: :btree
    t.index ["coupon_id"], name: "index_employee_coupons_on_coupon_id", using: :btree
    t.index ["employee_id"], name: "index_employee_coupons_on_employee_id", using: :btree
  end

  create_table "employee_otps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",      limit: 50
    t.string   "otp",        limit: 6
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["email"], name: "index_employee_otps_on_email", using: :btree
    t.index ["otp"], name: "index_employee_otps_on_otp", using: :btree
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id"
    t.string   "prefix",         limit: 4
    t.string   "first_name",     limit: 50
    t.string   "last_name",      limit: 50
    t.string   "middle_name",    limit: 50
    t.string   "email",          limit: 50
    t.string   "contact_number", limit: 20
    t.string   "address"
    t.boolean  "disabled",                  default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["company_id"], name: "index_employees_on_company_id", using: :btree
    t.index ["contact_number"], name: "index_employees_on_contact_number", using: :btree
    t.index ["email"], name: "index_employees_on_email", using: :btree
  end

end
