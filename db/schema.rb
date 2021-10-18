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

ActiveRecord::Schema.define(version: 2021_10_18_092749) do

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
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role", default: "User", null: false
  end

  add_foreign_key "basic_posters", "creators"
  add_foreign_key "quests", "basic_posters"
end
