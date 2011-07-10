# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
DietApp::Application.initialize!

# Basic CAS client configuration

require 'casclient'
require 'casclient/frameworks/rails/filter'

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://login.umd.edu/cas"
)


