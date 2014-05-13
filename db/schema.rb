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

ActiveRecord::Schema.define(version: 20140513004908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "graphs", force: true do |t|
    t.text    "graph_key"
    t.integer "repo_id"
  end

  create_table "repos", force: true do |t|
    t.string "title"
    t.text   "description"
    t.string "owner"
    t.string "repo_image"
    t.date   "start_date"
    t.date   "update_date"
  end

  create_table "repos_users", id: false, force: true do |t|
    t.integer "user_id", null: false
    t.integer "repo_id", null: false
  end

  add_index "repos_users", ["repo_id", "user_id"], name: "index_repos_users_on_repo_id_and_user_id", using: :btree
  add_index "repos_users", ["user_id", "repo_id"], name: "index_repos_users_on_user_id_and_repo_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "avatar"
    t.string   "email"
    t.string   "github_access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
