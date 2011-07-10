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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110710223349) do

  create_table "foods", :force => true do |t|
    t.decimal "added_sugars",          :precision => 10, :scale => 0
    t.decimal "alcohol",               :precision => 10, :scale => 0
    t.decimal "calories",              :precision => 10, :scale => 0
    t.string  "name"
    t.decimal "dark_green_vegetables", :precision => 10, :scale => 0
    t.decimal "dry_beans_peas",        :precision => 10, :scale => 0
    t.decimal "factor",                :precision => 10, :scale => 0
    t.decimal "food_id",               :precision => 10, :scale => 0
    t.decimal "fruits",                :precision => 10, :scale => 0
    t.decimal "grains",                :precision => 10, :scale => 0
    t.decimal "incr",                  :precision => 10, :scale => 0
    t.decimal "meats",                 :precision => 10, :scale => 0
    t.decimal "milk",                  :precision => 10, :scale => 0
    t.decimal "multiplier",            :precision => 10, :scale => 0
    t.decimal "oils",                  :precision => 10, :scale => 0
    t.decimal "orange_vegetables",     :precision => 10, :scale => 0
    t.decimal "other_vegetables",      :precision => 10, :scale => 0
    t.decimal "portion_amount",        :precision => 10, :scale => 0
    t.decimal "portion_default",       :precision => 10, :scale => 0
    t.string  "portion_display_name"
    t.decimal "saturated_fats",        :precision => 10, :scale => 0
    t.decimal "solid_fats",            :precision => 10, :scale => 0
    t.decimal "soy",                   :precision => 10, :scale => 0
    t.decimal "starchy_vegetables",    :precision => 10, :scale => 0
    t.decimal "vegetables",            :precision => 10, :scale => 0
    t.decimal "whole_grains",          :precision => 10, :scale => 0
    t.integer "meal_id"
  end

  create_table "meals", :force => true do |t|
    t.integer  "food_id"
    t.integer  "serving_size"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",        :precision => 8, :scale => 2
    t.integer  "location"
    t.date     "day"
    t.integer  "time_of_day"
  end

  add_index "meals", ["user_id"], :name => "index_meals_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "grad_year"
    t.integer  "birth_year"
    t.string   "UID"
    t.boolean  "is_male"
    t.integer  "height"
    t.boolean  "is_special"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
