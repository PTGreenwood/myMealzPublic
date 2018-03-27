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

ActiveRecord::Schema.define(version: 20180327012136) do

  create_table "database_structures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  end

  create_table "diet_client_plans", primary_key: ["dietitianid", "userid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "dietitianid", null: false, auto_increment: true
    t.bigint "userid", null: false
    t.integer "totalCalorieRestriction", null: false
    t.integer "protein", null: false
    t.integer "carbohydrates", null: false
    t.integer "fats", null: false
    t.integer "grains", null: false
    t.integer "vegetables", null: false
    t.index ["userid"], name: "diet-client-user-foreign"
  end

  create_table "dietitian_clients", primary_key: ["userid", "dietitianid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "dietitianid", null: false
    t.bigint "userid", null: false
    t.index ["dietitianid"], name: "dietitianid"
  end

  create_table "dietitian_practices", primary_key: ["practiceid", "dietitianid"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "practiceid", null: false
    t.integer "dietitianid", null: false
    t.index ["dietitianid"], name: "dietitianForeign"
  end

  create_table "dietitians", primary_key: "dietitianid", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "firstname", null: false
    t.text "lastname", null: false
    t.integer "practiceid", null: false
    t.bigint "userid"
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

  create_table "saved_meals", primary_key: ["saved_meals_id", "user_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "saved_meals_id", null: false, auto_increment: true
    t.text "content"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_saved_meals_on_user_id"
    t.index ["user_id"], name: "index_saved_meals_on_user_id_and_created_at"
  end

  create_table "user_fridges", primary_key: "userid", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  add_foreign_key "diet_client_plans", "dietitians", column: "dietitianid", primary_key: "dietitianid", name: "diet-client-diet-foreign"
  add_foreign_key "diet_client_plans", "users", column: "userid", name: "diet-client-user-foreign"
  add_foreign_key "dietitian_clients", "dietitians", column: "dietitianid", primary_key: "dietitianid", name: "dietitian_clients_ibfk_1"
  add_foreign_key "dietitian_clients", "users", column: "userid", name: "userForeign"
  add_foreign_key "dietitian_practices", "dietitians", column: "dietitianid", primary_key: "dietitianid", name: "dietitianForeign"
  add_foreign_key "dietitian_practices", "practices", column: "practiceid", primary_key: "practiceid", name: "practiceForeign"
  add_foreign_key "dietitians", "practices", column: "practiceid", primary_key: "practiceid", name: "dietitians_ibfk_1", on_delete: :cascade
  add_foreign_key "dietitians", "users", column: "userid", name: "dietitians_user_foreign"
  add_foreign_key "saved_meals", "users"
  add_foreign_key "user_fridges", "product_list", column: "productid", primary_key: "productid", name: "fridge-food-foreign"
  add_foreign_key "user_fridges", "users", column: "userid", name: "fridge-user-foreign"
  add_foreign_key "users", "dietitians", column: "dietitianID", primary_key: "dietitianid", name: "user_dietitianID_Foreign"
end
