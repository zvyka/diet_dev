class Credentials < ActiveRecord::Base
  attr_accessible :shared_secret, :consumer_key
end
