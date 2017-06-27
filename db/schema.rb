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

ActiveRecord::Schema.define(version: 20170627182200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tees", force: :cascade do |t|
    t.string   "color"
    t.decimal  "usga_course_rating_18"
    t.integer  "slope_rating_18"
    t.decimal  "front_9_rating"
    t.integer  "front_9_slope"
    t.decimal  "back_9_rating"
    t.integer  "back_9_slope"
    t.decimal  "bogey_rating",          precision: 4, scale: 1
    t.string   "gender"
    t.integer  "club_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.index ["club_id"], name: "index_tees_on_club_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
