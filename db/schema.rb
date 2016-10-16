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

ActiveRecord::Schema.define(version: 20161015133348) do

  create_table "comments", force: :cascade do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "portfolio_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "title"
    t.string   "path"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
    t.string   "category"
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "sex"
    t.date     "birthday"
    t.string   "city"
    t.string   "avatar"
    t.string   "phone_number"
    t.string   "social_email"
    t.string   "social_network"
    t.string   "hobby"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.float    "rating"
    t.integer  "user_id"
    t.integer  "portfolio_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "shootings", force: :cascade do |t|
    t.string   "category"
    t.float    "price"
    t.string   "image"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "remember_token"
    t.boolean  "operator"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "videographies", force: :cascade do |t|
    t.string   "category"
    t.float    "price"
    t.string   "image"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.string   "path"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "category"
  end

end
