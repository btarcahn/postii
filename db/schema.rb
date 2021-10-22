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

ActiveRecord::Schema.define(version: 2021_10_22_023440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "basic_posters", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "poster_id"
    t.string "title"
    t.string "description"
    t.string "security_question"
    t.string "security_answer"
    t.string "passcode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_basic_posters_on_creator_id"
  end

  create_table "creators", force: :cascade do |t|
    t.string "creator_name"
    t.string "email_address"
    t.string "sector_code"
    t.string "prefix_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "elevation_requests", force: :cascade do |t|
    t.bigint "creator_id", null: false
    t.integer "status", null: false
    t.bigint "created_by_id", null: false
    t.bigint "target_id", null: false
    t.bigint "answered_by_id"
    t.datetime "due_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answered_by_id"], name: "index_elevation_requests_on_answered_by_id"
    t.index ["created_by_id"], name: "index_elevation_requests_on_created_by_id"
    t.index ["creator_id"], name: "index_elevation_requests_on_creator_id"
    t.index ["target_id"], name: "index_elevation_requests_on_target_id"
  end

  create_table "err_msgs", force: :cascade do |t|
    t.string "err_code"
    t.string "message"
    t.string "reason"
    t.string "component"
    t.string "additional_note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "quests", force: :cascade do |t|
    t.string "quest_type"
    t.boolean "mandatory"
    t.string "question"
    t.string "answer"
    t.bigint "basic_poster_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["basic_poster_id"], name: "index_quests_on_basic_poster_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role", default: "User", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "basic_posters", "creators"
  add_foreign_key "elevation_requests", "creators"
  add_foreign_key "elevation_requests", "users", column: "answered_by_id"
  add_foreign_key "elevation_requests", "users", column: "created_by_id"
  add_foreign_key "elevation_requests", "users", column: "target_id"
  add_foreign_key "quests", "basic_posters"
end
