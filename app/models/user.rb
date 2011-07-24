# == Schema Information
# Schema version: 20110306021919
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  grad_year  :integer(4)
#  birth_year :integer(4)
#  UID        :string(255)
#  is_male    :boolean(1)
#  height     :integer(4)
#  is_special :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest'

class User < ActiveRecord::Base
   attr_accessor :password
  attr_accessible :name, :email, :UID, :birth_year, :grad_year, :is_male, :height, :is_special 
  
  has_many :meals , :dependent => :destroy

  #email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  email_regex = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i #newer regex, better?
  
  name_regex = /\A[a-zA-Z]+\z/
  
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 },
                    :format => { :with => name_regex, :message => "Invalid name format"}
                    
  validates :email, :presence => true,
                    :format   => { :with => email_regex, :message => "Not a valid email format" },
                    :uniqueness => {:case_sensitive  => false }

  validates :UID, :presence => true, #UMD UID
                  :uniqueness => true
  validates :birth_year, :presence => true, #Year of birth
                         :numericality => true,
                         :inclusion => {:in => 1985..1995}
  validates :grad_year, :presence => true, #year of grad.
                        :numericality => true,
                        :inclusion => {:in => 2011..2017}
  validates :height, :presence => true,
                     :numericality => { :greater_than => 0}
  

  def self.authenticate_with_UID(uid)
    user = find_by_UID(uid)
    if user.nil?
      return nil 
    else
      return user
    end
  end
     
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

