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
  attr_accessible :name, :email, 
                  #:password, :password_confirmation, 
                  :UID, :birth_year, :grad_year, :is_male, :height, :is_special 
  
  has_many :meals #, :dependent => :destroy

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => {:case_sensitive  => false }
  # Automatically create the virtual attribute 'password_confirmation'.
   # validates :password, :presence     => true,
   #                               :confirmation => true,
   #                               :length       => { :within => 6..40 }
  
  validates :UID, :presence => true, #UMD UID
                  :uniqueness => true
  validates :birth_year, :presence => true, #Year of birth
                         :numericality => true,
                         :inclusion => {:in => 1985..1995}
  validates :grad_year, :presence => true, #year of grad.
                        :numericality => true,
                        :inclusion => {:in => 2011..2017}
  validates :height, :presence => true,
                     :numericality => true
  
  #before_save :encrypt_password
  
  # Return true if the user's password matches the submitted password.
   def has_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
   end
  
  # def self.authenticate(email, submitted_password)
  #     user = find_by_email(email)
  #     return nil if user.nil?
  #     return user if user.has_password?(submitted_password)
  #   end

  def self.authenticate_with_UID(uid)
    user = find_by_UID(uid)
    if user.nil?
      return nil 
    else
      return user
    end
  end
   
   # def self.authenticate_with_salt(id, cookie_salt)
   #      user = find_by_id(id)
   #      (user && user.salt == cookie_salt) ? user : nil
   #    end 

     
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
     
  private
     # def encrypt_password
     #        self.salt = make_salt if new_record?
     #        self.encrypted_password = encrypt(password)
     #      end
     #      def encrypt(string)
     #        secure_hash("#{salt}--#{string}")
     #      end
     #      def make_salt
     #        secure_hash("#{Time.now.utc}--#{password}")
     #      end
     #      def secure_hash(string)
     #        Digest::SHA2.hexdigest(string)
     #      end
end

