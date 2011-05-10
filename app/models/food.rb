class Food < ActiveRecord::Base
  attr_accessible :added_sugars, :alcohol, :calories, :name, :dark_green_vegetables, :dry_beans_peas, :factor, :food_id, :fruits, :grains, :increment, :meats, :milk, :multiplier, :oils, :orange_vegetables, :other_vegetables, :portion_amount, :portion_default, :portion_display_name, :saturated_fats, :solid_fats, :soy, :starchy_vegetables, :vegetables, :whole_grains
  
  belongs_to :meal
  
  validates :serving_size, :presence => true,
                           :numericality => true,
                           :allow_blank => false
  validates :day, :presence => true
  validates :time_of_day, :presence => true
  validates :location, :presence => true
  validates :price, :presence => true
  
  def index
    @meals = Meal.search(params[:search])
  end
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
end
