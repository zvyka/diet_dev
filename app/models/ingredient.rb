class Ingredient < ActiveRecord::Base
  attr_accessible :food_id, :meal_id
  belongs_to :meal
  belongs_to :food
end