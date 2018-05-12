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

ActiveRecord::Schema.define(version: 20180512121620) do

  create_table "contracts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "UserID"
    t.integer "DietitianID"
    t.integer "totalCalRestriction"
    t.integer "proteinReq"
    t.integer "fruitReq"
    t.integer "dairyReq"
    t.integer "vegeReq"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "grainsReq"
    t.integer "fatsReq"
    t.integer "discReq"
  end

  create_table "database_structures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "productID"
    t.string "productName"
    t.integer "totalCal"
    t.integer "proteinQty"
    t.integer "carbohydrateQty"
    t.integer "fatsQty"
    t.string "productType"
    t.integer "servingQty"
    t.string "servingType"
  end

  create_table "saved_meals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_saved_meals_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_saved_meals_on_user_id"
  end

  create_table "support_tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ticketTitle"
    t.integer "attachedToTicket"
    t.text "subjectBody", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "resolved"
    t.string "admin_assigned"
    t.boolean "isAdminMessage"
    t.boolean "isPartOfThread"
    t.string "sender"
    t.bigint "attachedUserID"
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
    t.boolean "admin_role", default: false
    t.boolean "dietitian_role", default: false
    t.boolean "user_role", default: true
    t.string "dietitianID"
    t.string "connectedTo"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
