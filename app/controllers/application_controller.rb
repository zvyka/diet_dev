class ApplicationController < ActionController::Base
    protect_from_forgery
          include SessionsHelper
    # This will allow the user to view the index page without authentication
      # but will process CAS authentication data if the user already
      # has an SSO session open.
    #    before_filter CASClient::Frameworks::Rails::GatewayFilter, :only => [:home, :about, :faq, :privacy_statement]
    # 
    #   # This requires the user to be authenticated for viewing allother pages.
    #    before_filter CASClient::Frameworks::Rails::Filter, :except => [:home, :about, :faq, :privacy_statement]
    # 
    # 
    # def logout
    #    CASClient::Frameworks::Rails::Filter.logout(self)
    #  end 

end
