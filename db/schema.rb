# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130706000602) do

  create_table "songs", force: true do |t|
    t.string   "title"
    t.string   "type"
    t.string   "url"
    t.string   "embed"
    t.string   "active"
    t.integer  "submission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["submission_id"], name: "index_songs_on_submission_id"

  create_table "submissions", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter"
    t.string   "email"
  end

  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id"

  create_table "videos", force: true do |t|
    t.string   "type"
    t.string   "title"
    t.string   "url"
    t.string   "embed"
    t.string   "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "submission_id"
  end

  add_index "videos", ["submission_id"], name: "index_videos_on_submission_id"

end
