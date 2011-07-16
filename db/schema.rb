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

ActiveRecord::Schema.define(:version => 20110716072509) do

  create_table "foods", :primary_key => "food_id", :force => true do |t|
    t.string "name"
    t.float  "water"
    t.float  "calories"
    t.float  "protein"
    t.float  "lipid_total"
    t.float  "ash"
    t.float  "carbohydrates"
    t.float  "fiber"
    t.float  "sugar_total"
    t.float  "calcium"
    t.float  "iron"
    t.float  "magnesium"
    t.float  "phosphorus"
    t.float  "potassium"
    t.float  "sodium"
    t.float  "zinc"
    t.float  "copper"
    t.float  "manganese"
    t.float  "selenium"
    t.float  "vit_c"
    t.float  "thiamin"
    t.float  "riboflavin"
    t.float  "niacin"
    t.float  "panto_acid"
    t.float  "vit_b6"
    t.float  "folate_total"
    t.float  "folic_acid"
    t.float  "food_folate"
    t.float  "folate_dfe"
    t.float  "choline_total"
    t.float  "vit_b12"
    t.float  "vit_a_iu"
    t.float  "vit_a_rae"
    t.float  "retinol"
    t.float  "alpha_carotene"
    t.float  "beta_carotene"
    t.float  "beta_crypt"
    t.float  "lycopene"
    t.float  "lut_zea"
    t.float  "vit_e"
    t.float  "vit_d_mcg"
    t.float  "vit_d_iu"
    t.float  "vit_k"
    t.float  "fa_sat"
    t.float  "fa_mono"
    t.float  "fa_poly"
    t.float  "cholesterol"
    t.float  "weight_1_gms"
    t.string "weight_1_desc"
    t.float  "weight_2_gms"
    t.string "weight_2_desc"
    t.float  "refuse_pct"
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
