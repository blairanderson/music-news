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

ActiveRecord::Schema.define(version: 20140305145644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "keychains", force: true do |t|
    t.string   "api_secret"
    t.string   "api_token"
    t.string   "auth_credentials_secret"
    t.string   "auth_credentials_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keychains", ["user_id"], name: "index_keychains_on_user_id", using: :btree

  create_table "rs_evaluations", force: true do |t|
    t.string   "reputation_name"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.float    "value",           default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rs_evaluations", ["reputation_name", "source_id", "source_type", "target_id", "target_type"], name: "index_rs_evaluations_on_reputation_name_and_source_and_target", unique: true, using: :btree
  add_index "rs_evaluations", ["reputation_name"], name: "index_rs_evaluations_on_reputation_name", using: :btree
  add_index "rs_evaluations", ["source_id", "source_type"], name: "index_rs_evaluations_on_source_id_and_source_type", using: :btree
  add_index "rs_evaluations", ["target_id", "target_type"], name: "index_rs_evaluations_on_target_id_and_target_type", using: :btree

  create_table "rs_reputation_messages", force: true do |t|
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "receiver_id"
    t.float    "weight",      default: 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rs_reputation_messages", ["receiver_id", "sender_id", "sender_type"], name: "index_rs_reputation_messages_on_receiver_id_and_sender", unique: true, using: :btree
  add_index "rs_reputation_messages", ["receiver_id"], name: "index_rs_reputation_messages_on_receiver_id", using: :btree
  add_index "rs_reputation_messages", ["sender_id", "sender_type"], name: "index_rs_reputation_messages_on_sender_id_and_sender_type", using: :btree

  create_table "rs_reputations", force: true do |t|
    t.string   "reputation_name"
    t.float    "value",           default: 0.0
    t.string   "aggregated_by"
    t.integer  "target_id"
    t.string   "target_type"
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], name: "index_rs_reputations_on_reputation_name_and_target", unique: true, using: :btree
  add_index "rs_reputations", ["reputation_name"], name: "index_rs_reputations_on_reputation_name", using: :btree
  add_index "rs_reputations", ["target_id", "target_type"], name: "index_rs_reputations_on_target_id_and_target_type", using: :btree

  create_table "songs", force: true do |t|
    t.string   "title"
    t.string   "type"
    t.string   "url"
    t.integer  "submission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumbnail_url"
    t.text     "embed"
    t.string   "stream_url"
    t.integer  "play_count",        default: 0
    t.integer  "comment_count",     default: 0
    t.integer  "download_count",    default: 0
    t.integer  "playback_count",    default: 0
    t.integer  "favoritings_count", default: 0
    t.integer  "status_cd",         default: 0, null: false
  end

  add_index "songs", ["status_cd"], name: "index_songs_on_status_cd", using: :btree
  add_index "songs", ["submission_id"], name: "index_songs_on_submission_id", using: :btree

  create_table "submissions", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter"
    t.string   "email"
    t.integer  "view_count",  default: 0
    t.integer  "songs_count", default: 0
  end

  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_song_tags", force: true do |t|
    t.integer  "user_id",    default: 0, null: false
    t.integer  "song_id",    default: 0, null: false
    t.integer  "tag_id",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_song_tags", ["song_id"], name: "index_user_song_tags_on_song_id", using: :btree
  add_index "user_song_tags", ["tag_id", "user_id", "song_id"], name: "index_user_song_tags_on_tag_id_and_user_id_and_song_id", unique: true, using: :btree
  add_index "user_song_tags", ["tag_id"], name: "index_user_song_tags_on_tag_id", using: :btree
  add_index "user_song_tags", ["user_id"], name: "index_user_song_tags_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  add_index "videos", ["submission_id"], name: "index_videos_on_submission_id", using: :btree

end
