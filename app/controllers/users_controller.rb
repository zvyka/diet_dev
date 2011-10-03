class UsersController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => [:destroy, :index]
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
    @login_url = CASClient::Frameworks::Rails::Filter.login_url(self)
    @username = session[:casfilteruser]   
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end

  def show
    @username = session[:casfilteruser]
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    
    
    @dvs = {:total_fat => 65, :fa_sat => 20, :cholesterol => 300, :sodium => 2400, :potassium => 3500,
            :tot_carbs => 300, :fiber => 25, :protein => 50, :vit_c => 60, :calcium => 1000, :iron => 18, 
            :sugar_total => 40}
        
    if User.find_by_id(params[:id]).nil?
      deny_access
    elsif User.find_by_id(params[:id]) == User.authenticate_with_UID(@username)
      @user = User.find_by_id(params[:id])
      @foods = Food.search(params[:search])
      @title = @user.name
    else
      deny_access
    end
  end

  def new
    @user = User.new
    @title = "Sign up"
    @login_url = CASClient::Frameworks::Rails::Filter.login_url(self)
    @username = session[:casfilteruser]
    if !User.authenticate_with_UID(@username).nil?  #if the user exists, sign in instead.
      if @username != 'jindig'
        redirect_to signin_path, :notice => "Please sign in."
      end
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to @user
      f = File.new('/Users/jon/Sites/mail_pass.txt')
      pass= f.gets
      Pony.mail(:from => 'teamdietumd@gmail.com', :to => @user.email, :subject => 'Team DIET Welcomes You!', 
                :html_body => "<p>Dear #{@user.name}</p> <p> Welcome to our online diet-tracking tool! Your account is now active and ready for you to begin tracking your meals. You may log in at any time using your UID and password at <a href='http://diettracker.umd.edu'>http://diettracker.umd.edu</a>. Please refer to our Help section on our website to familiarize yourself with our tool.</p> <p>Please be on the lookout for a quick survey we will be emailing out in a few days to confirm your entry to the <b>Ipod Touch Raffle</b></p> <p> We thank you for participating in our research study.  </p> <p>Sincerely,</p> <p>Team DIET</p> <p>Gemstone Program,  UMD Honors Program</p> <p>*By virtue of logging into and using this diet tracker, you agree to the terms and conditions as listed at http://diettracker.umd.edu/terms *</p>",
                :body => "Dear #{@user.name},

                Welcome to our online diet-tracking tool! Your account is now active and ready for you to begin tracking your meals. You may log in at any time using your UID and password at http://diettracker.umd.edu. Please refer to our Help section on our website to familiarize yourself with our tool. 
                  
                Please be on the lookout for a quick survey we will be emailing out in a few days to confirm your entry to the **Ipod Touch Raffle.**

                We thank you for participating in our research study. 

                Sincerely, 
                	Team DIET
                	Gemstone Program, A. James Clark School of Engineering 

                	*By virtue of logging into and using this diet tracker, you agree to the terms and conditions as listed at http://diettracker.umd.edu/terms *" ,:via => :smtp, :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => 'teamdietumd@gmail.com',
          :password             => pass,
          :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
          :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
        })
    else
      @title = "Oops"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def analysis
    @username = session[:casfilteruser]
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
      
    sign_in User.authenticate_with_UID(@username)
    @title = "Analysis"
    @meals = Meal.find_all_by_user_id_and_date_eaten(current_user, @date.beginning_of_month..@date.end_of_month, :order => :date_eaten)
    
    dupe_list = ""
    dupe_date = ""
    orig_meal_id = ""
    @meals.each do |m|
      if m.date_eaten != dupe_date
        dupe_date = m.date_eaten
        orig_meal_id = m.id
      else
        dupe_list = "#{dupe_list} #{orig_meal_id}"
        dupe_date = m.date_eaten
        orig_meal_id = m.id
      end
    end
    
    @dupes = dupe_list
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to edit_user_path(@user)
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  def deny_access
      redirect_to signin_path, :notice => "Please sign in to access this page."
  end    
    
  private

    def authenticate
        deny_access unless signed_in?
      end
      
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
end
