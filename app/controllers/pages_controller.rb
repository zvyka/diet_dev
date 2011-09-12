class PagesController < ApplicationController
   before_filter CASClient::Frameworks::Rails::GatewayFilter, :only => [:home, :about, :faq, :privacy_statement, :help, :terms]
   
     # This requires the user to be authenticated for viewing allother pages.
      before_filter CASClient::Frameworks::Rails::Filter, :except => [:home, :about, :faq, :privacy_statement, :help, :terms]
   
   
  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
  
  def home
    @title = "Home"
    @meal = Meal.new if signed_in?
    @foods = Food.search(params[:search])
    @login_url = CASClient::Frameworks::Rails::Filter.login_url(self)
    @username = session[:casfilteruser] 
    if signed_in?
      redirect_to user_path(current_user), :notice => "Welcome!"
    elsif !User.authenticate_with_UID(@username).nil?
      redirect_to signin_path, :notice => "Please sign in"  
    end
  end
  
  def login
    @title = "Log in"
    @login_url = CASClient::Frameworks::Rails::Filter.login_url(self)
    @username = session[:casfilteruser] 
    if signed_in?
      redirect_to user_path(current_user), :notice => "Welcome!"
    elsif !User.authenticate_with_UID(@username).nil?
      redirect_to signin_path #, :notice => "Please sign in"  
    else
      redirect_to signup_path, :notice => "First time? We just need a little more information about you and then you're all set. Thanks!"
    end
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