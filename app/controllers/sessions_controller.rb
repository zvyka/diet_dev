class SessionsController < ApplicationController
    
  # def new
  #   @title = "Sign in"
  # end
  
  def create
    user = User.authenticate_with_UID(session[:cas_user])
    if user.nil?
      flash.now[:error] = "Oops, looks like you are a new user, please click the link on the bottom of the page to continue."
      @title = "Sign up"
      #redirect_to signup_path
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    #redirect_to root_path
  end
end
