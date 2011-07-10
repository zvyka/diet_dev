class PagesController < ApplicationController
   before_filter CASClient::Frameworks::Rails::GatewayFilter, :only => [:home, :about, :faq, :privacy_statement]
   
     # This requires the user to be authenticated for viewing allother pages.
      before_filter CASClient::Frameworks::Rails::Filter, :except => [:home, :about, :faq, :privacy_statement]
   
   
   def logout
      CASClient::Frameworks::Rails::Filter.logout(self)
    end
  def home
    @title = "Home"
    @meal = Meal.new if signed_in?
    @foods = Food.search(params[:search])
    @login_url = CASClient::Frameworks::Rails::Filter.login_url(self)
    @username = session[:casfilteruser] 
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end
  
  def help
    @title = "Help"
  end
  
  def analysis
    @title = "Analysis"
  end
  
  def terms
    @title = "Terms and Conditions"
  end
  
  def privacy
    @title = "Privacy Policy"
  end
  
  def faq
    @title = "Frequently Asked Questions"
  end
end