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

ActiveRecord::Schema.define(version: 20181213055204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.string "gid"
    t.string "email"
    t.string "name"
    t.boolean "organizer"
    t.string "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "items"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.datetime "starts"
    t.datetime "ends"
    t.string "gid"
    t.string "description"
    t.string "hangout_link"
    t.text "note"
    t.string "creator"
    t.string "location"
    t.string "category"
    t.integer "user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "event_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_id"
    t.string "event_title"
    t.boolean "completed", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "email"
    t.string "google_token"
    t.string "google_refresh_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "theme", default: "dark", null: false
  end

end
