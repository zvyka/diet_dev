class Meal < ActiveRecord::Base
  has_many :ingredients, :dependent => :destroy
  accepts_nested_attributes_for :ingredients, :reject_if => lambda { |a| a[:what_food].blank? }, :allow_destroy => true
  
  validates_presence_of :ingredients, :message => "You need to specify a food!"
  
  def self.search(search, user_id)
    if search
      where("date_eaten LIKE ? AND user_id=#{user_id}", "%#{search}%")
    else
      scoped
    end
  end
  
end
