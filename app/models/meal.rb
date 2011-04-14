class Meal < ActiveRecord::Base
  attr_accessible :food_id, :serving_size
  
  belongs_to :user
  
  has_many :foods
  
  validates :food_id, :presence => true
  validates :serving_size, :presence => true
  validates :user_id, :presence => true
  
  default_scope :order => 'meals.created_at DESC'
end
