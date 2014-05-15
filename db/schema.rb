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

ActiveRecord::Schema.define(version: 20140514155347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commits", force: true do |t|
    t.string  "sha"
    t.string  "committer"
    t.integer "additions"
    t.integer "deletions"
    t.date    "date"
    t.integer "repo_id"
  end

  add_index "commits", ["repo_id"], name: "index_commits_on_repo_id", using: :btree

  create_table "repos", force: true do |t|
    t.string  "title"
    t.string  "repo_path"
    t.text    "description"
    t.string  "owner"
    t.date    "start_date"
    t.date    "update_date"
    t.integer "user_id"
  end

  add_index "repos", ["user_id"], name: "index_repos_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "avatar"
    t.string   "email"
    t.string   "github_access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
