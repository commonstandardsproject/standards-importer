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

ActiveRecord::Schema.define(version: 20150708101057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jurisdictions", force: :cascade do |t|
    t.string "csp_id"
    t.json   "document"
    t.string "title"
    t.string "type"
  end

  add_index "jurisdictions", ["csp_id"], name: "index_jurisdictions_on_csp_id", using: :btree

  create_table "standards", force: :cascade do |t|
    t.integer "jurisdiction_id",                  null: false
    t.string  "csp_id"
    t.integer "parent_ids",       default: [],    null: false, array: true
    t.string  "education_levels", default: [],    null: false, array: true
    t.string  "title"
    t.string  "subject"
    t.json    "document"
    t.boolean "indexed",          default: false, null: false
  end

  add_index "standards", ["csp_id"], name: "index_standards_on_csp_id", using: :btree
  add_index "standards", ["jurisdiction_id"], name: "index_standards_on_jurisdiction_id", using: :btree
  add_index "standards", ["parent_ids"], name: "index_standards_on_parent_ids", using: :gin

  create_table "standards_schema_migrations", id: false, force: :cascade do |t|
    t.string "version", null: false
  end

  add_foreign_key "standards", "jurisdictions"
end
