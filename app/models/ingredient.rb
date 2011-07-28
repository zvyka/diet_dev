class Ingredient < ActiveRecord::Base
  attr_accessible :food_id, :meal_id
  # belongs_to :meal
  # belongs_to :food
  
  belongs_to :meal
  # belongs_to :foods
  
  #accepts_nested_attributes_for :foods
  
  # attr_reader :food_tokens
  # 
  # def food_tokens=(tokens)
  #   params[:meal][:food_tokens] = tokens
  # end
end