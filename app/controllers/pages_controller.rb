class PagesController < ApplicationController

  def home
    @title = "Home"
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
