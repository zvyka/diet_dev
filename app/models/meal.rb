class Meal < ActiveRecord::Base
  has_many :ingredients, :dependent => :destroy
  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:food_id].blank? }, :allow_destroy => true
  
  validates_presence_of :ingredients, :message => "You need to specify a food!"
  
  validates_uniqueness_of :date_eaten, :scope => :user_id
      
  # def self.on_month(day) 
  #   where("MONTH(date_eaten) = ?", day.month)  
  # end
  
 # scope :this_month, on_month(day)
  
  
  def self.search(search, user_id)
    if search
      where("date_eaten LIKE ? AND user_id=#{user_id}", "%#{search}%")
    else
      scoped
    end
  end
end
