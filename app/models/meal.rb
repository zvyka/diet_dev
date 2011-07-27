class Meal < ActiveRecord::Base
  attr_accessible :id, :user_id, :food_tokens, :food_id, :servings, :date_eaten, :time_of_day, :location, :price
  
  belongs_to :user
  
  has_many :ingredients, :dependent => :destroy
  has_many :foods, :through => :ingredients
  accepts_nested_attributes_for :ingredients
  
  
  
  attr_reader :food_tokens
  
  def food_tokens=(ids)
    self.food_ids = ids.split(",")    
  end

  validates :date_eaten, :presence => true
  validates :time_of_day, :presence => true
  validates :location, :presence => true
  validates :price, :presence => true

  def index
    @foods = Food.search(params[:search])
    @meals = Meal.search(params[:search])
  end
  
end
