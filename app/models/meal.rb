class Meal < ActiveRecord::Base
  attr_accessible :food_id, :serving_size, :day, :time_of_day, :location, :price
  
  belongs_to :user
  
  has_one :foods
  
  validates :serving_size, :presence => true,
                           :numericality => true,
                           :allow_blank => false
  validates :day, :presence => true
  validates :time_of_day, :presence => true
  validates :location, :presence => true
  validates :price, :presence => true

  accepts_nested_attributes_for :foods
  
  default_scope :order => 'meals.created_at DESC'
  
  def index
    @foods = Food.search(params[:search])
    @meals = Meal.search(params[:search])
  end
  
end
