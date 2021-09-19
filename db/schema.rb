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

ActiveRecord::Schema.define(version: 2021_09_17_093827) do

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

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "basic_posters", "creators"
end
