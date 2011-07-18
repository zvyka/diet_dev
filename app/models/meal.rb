class Meal < ActiveRecord::Base
  attr_accessible :id, :user_id, :food_tokens, :food_id,  :date_eaten, :time_of_day, :location, :price
  
  belongs_to :user
  
  has_many :ingredients
  has_many :foods, :through => :ingredients
  attr_reader :food_tokens
  
  def food_tokens=(ids)
    self.food_ids = ids.split(",")
  end
  
  # validates :serving_size, :presence => true,
  #                            :numericality => true,
  #                            :allow_blank => false
  validates :date_eaten, :presence => true
  validates :time_of_day, :presence => true
  validates :location, :presence => true
  validates :price, :presence => true

  # accepts_nested_attributes_for :foods
  
  # default_scope :order => 'meals.created_at DESC'
  
  def index
    @foods = Food.search(params[:search])
    @meals = Meal.search(params[:search])
  end
  

  
  # def food_name
  #     foods.name if foods
  #   end
  # 
  #   def food_name=(name)
  #     self.foods = Food.find_by_name(name) unless name.blank?
  #   end
  
end
