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

ActiveRecord::Schema.define(version: 20180327044529) do

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "database_structures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  end

  create_table "dietclientplans", primary_key: "planid", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "dietitianid", null: false
    t.bigint "user_id", null: false
    t.integer "totalCalorieRestriction", null: false
    t.integer "protein", null: false
    t.integer "carbohydrates", null: false
    t.integer "fats", null: false
    t.integer "grains", null: false
    t.integer "vegetables", null: false
  end

  create_table "dietitianclients", primary_key: "dietclient_tempid", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "dietitianid", null: false
    t.bigint "user_id", null: false
  end

  create_table "dietitianpractices", primary_key: "dietprac_tempid", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "practiceid", null: false
    t.integer "dietitianid", null: false
  end

  create_table "dietitians", primary_key: "dietitianid", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "firstname", null: false
    t.text "lastname", null: false
    t.integer "practiceid", null: false
    t.bigint "userid", null: false
    t.index ["practiceid"], name: "PracticeID"
    t.index ["userid"], name: "dietitians_user_foreign"
  end

  create_table "practices", primary_key: "practiceid", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "name", null: false
    t.text "suburb", null: false
    t.integer "postcode", null: false
    t.integer "number", null: false
    t.text "address", null: false
  end

  create_table "savedmeals", primary_key: "saved_meals_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content"
  end

  create_table "userfridges", primary_key: "userid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "productid", null: false
    t.integer "quantity", null: false
    t.integer "dateAdded", null: false
    t.integer "dateDueToExpire"
    t.index ["productid"], name: "fridge-food-foreign"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "firstname"
    t.string "lastname"
    t.integer "dietitianID", default: 0
    t.boolean "admin_role", default: false, null: false
    t.boolean "dietitian_role", default: false, null: false
    t.boolean "user_role", default: true, null: false
    t.index ["dietitianID"], name: "user_dietitianID_Foreign"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "userfridges", "users", column: "userid", name: "fridge-user-foreign"
end
