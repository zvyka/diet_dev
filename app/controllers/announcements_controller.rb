class AnnouncementsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :authenticate
  
  # GET /announcements
  # GET /announcements.xml
  def index
    @announcements = Announcement.all
    if current_user.group_id != 3
      redirect_to user_path(current_user), :notice => "Unauthorized User."
    end
      
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @announcements }
    end
  end

  def admin
    if current_user.group_id != 3
      redirect_to user_path(current_user), :notice => "Unauthorized User."
    end
    
    @users = ""
    @meals = ""
    @m_per_u = ""
    @dates = "" 
    lines = IO.readlines('/Users/jon/Sites/diet_app/stats.txt')
    lines.each do |l| 
      if l != lines.first
        arr = l.split(',')
        @users = "#{@users + "," if !@users.blank?} #{arr[0]}"
        @meals = "#{@meals + "," if !@meals.blank?} #{arr[1]}"
        @m_per_u = "#{@m_per_u + "," if !@m_per_u.blank?} #{arr[2].to_f.round(2)}"
        @dates = "#{@dates + "," if !@dates.blank?} '#{Time.parse(arr[3]).strftime('%b. %e')}'"
      end
    end
    
    @top_users = ""
    @top_meals = ""
    
    User.all.each do |user|
      num_meals = Meal.find_all_by_user_id(user.id).size
      if num_meals > 20
        @top_users = "#{@top_users + "," if !@top_users.blank?} '#{user.name}'"
        @top_meals = "#{@top_meals + "," if !@top_meals.blank?} #{num_meals}"
      end
    end
    
    @exp_users = ""
    @exp_meals = ""
    @exp_m_per_u = ""
    @exp_dates = "" 
    lines = IO.readlines('/Users/jon/Sites/diet_app/exp_stats.txt')
    lines.each do |l| 
      if l != lines.first
        arr = l.split(',')
        @exp_users = "#{@exp_users + "," if !@exp_users.blank?} #{arr[0]}"
        @exp_meals = "#{@exp_meals + "," if !@exp_meals.blank?} #{arr[1]}"
        @exp_m_per_u = "#{@exp_m_per_u + "," if !@exp_m_per_u.blank?} #{arr[2].to_f.round(2)}"
        @exp_dates = "#{@exp_dates + "," if !@exp_dates.blank?} '#{Time.parse(arr[3]).strftime('%b. %e')}'"
      end
    end
    
    @exp_1_users = ""
    @exp_1_meals = ""
    @exp_1_m_per_u = ""
    @exp_1_dates = "" 
    lines = IO.readlines('/Users/jon/Sites/diet_app/new_exp_1_stats.txt')
    lines.each do |l| 
      if l != lines.first
        arr = l.split(',')
        @exp_1_users = "#{@exp_1_users + "," if !@exp_1_users.blank?} #{arr[0]}"
        @exp_1_meals = "#{@exp_1_meals + "," if !@exp_1_meals.blank?} #{arr[1]}"
        @exp_1_m_per_u = "#{@exp_1_m_per_u + "," if !@exp_1_m_per_u.blank?} #{arr[2].to_f.round(2)}"
        @exp_1_dates = "#{@exp_1_dates + "," if !@exp_1_dates.blank?} '#{Time.parse(arr[3]).strftime('%b. %e')}'"
      end
    end
    
    @exp_2_users = ""
    @exp_2_meals = ""
    @exp_2_m_per_u = ""
    @exp_2_dates = "" 
    lines = IO.readlines('/Users/jon/Sites/diet_app/new_exp_2_stats.txt')
    lines.each do |l| 
      if l != lines.first
        arr = l.split(',')
        @exp_2_users = "#{@exp_2_users + "," if !@exp_2_users.blank?} #{arr[0]}"
        @exp_2_meals = "#{@exp_2_meals + "," if !@exp_2_meals.blank?} #{arr[1]}"
        @exp_2_m_per_u = "#{@exp_2_m_per_u + "," if !@exp_2_m_per_u.blank?} #{arr[2].to_f.round(2)}"
        @exp_2_dates = "#{@exp_2_dates + "," if !@exp_2_dates.blank?} '#{Time.parse(arr[3]).strftime('%b. %e')}'"
      end
    end
    
   #Getting all experimental group 1
    new_exp_users = User.find_all_by_group_id(1)
    @new_num_exp_1_users = new_exp_users.size
    @total_meals_1 = 0
    new_exp_users.each do |user|
      meals = Meal.find_all_by_user_id(user.id)
      @total_meals_1 = @total_meals_1 + meals.size
      
      meals.each do |meal|
        @new_1_meals = "#{@new_1_meals + "" if !@new_1_meals.blank?} #{meals.size}"
      end
    end
      
   #Getting all experimental group 2
    new_exp_users = User.find_all_by_group_id(2)
    @new_num_exp_2_users = new_exp_users.size
    @total_meals_2 = 0
    new_exp_users.each do |user|
      meals = Meal.find_all_by_user_id(user.id)
      @total_meals_2 = @total_meals_2 + meals.size
      meals.each do |meal|
        @new_2_meals = "#{@new_2_meals + "" if !@new_2_meals.blank?} #{meals.size}"
      end
    end
    
     @pie_chart_values = "{name: 'Exp Group 1', y: #{@total_meals_1.to_i}},{name: 'Exp Group 2', y: #{@total_meals_2.to_i}}"
		
		 @new_users = ""
     @new_meals = ""
     @new_m_per_u = ""
     @new_dates = "" 
     lines = IO.readlines('/Users/jon/Sites/diet_app/new_stats.txt')
     lines.each do |l| 
       if l != lines.first
         arr = l.split(',')
         @new_users = "#{@new_users + "," if !@new_users.blank?} #{arr[0]}"
         @new_meals = "#{@new_meals + "," if !@new_meals.blank?} #{arr[1]}"
         @new_m_per_u = "#{@new_m_per_u + "," if !@new_m_per_u.blank?} #{arr[2].to_f.round(2)}"
         @new_dates = "#{@new_dates + "," if !@new_dates.blank?} '#{arr[3].chomp}'"
       end
     end
		
  end
  
  def send_mail
    name = params[:email][:name]
    subject = params[:email][:subject]
    html_body = params[:email][:html_body]
    body = params[:email][:body]
    group = params[:email][:group].to_i
    current_user_id = params[:email][:user_id].to_i

    if group == 0
      users = User.all
    elsif group == 1
      users = User.find_all_by_group_id(1)
    elsif group == 2
      users = User.find_all_by_group_id(2)
    elsif group == 3
      users = User.find_all_by_group_id(1..2)
    elsif group == 4
      users = User.find_all_by_group_id(3)
    elsif group == 5
      users = User.find_all_by_id(current_user_id)
    end
    
    f = File.new('/Users/jon/Sites/mail_pass.txt')
    pass= f.gets
    
    if users.size > 50
      count = 0
      users.each do |user|   
        count = count +1
         if count % 50 == 0
           sleep 60 #sleep for 60 seconds after every 50 emails sent
           logger.info "slept for 60 seconds"
         end
         this_subject = subject.gsub('#{user.name}', user.name)
         this_html = html_body.gsub('#{user.name}', user.name)
         this_body = body.gsub('#{user.name}', user.name)
        Pony.mail(:from => "#{name} <teamdietumd@gmail.com>", :to => user.email, :subject => this_subject, 
                  :html_body => this_html,
                  :body => this_body ,:via => :smtp, :via_options => {
            :address              => 'smtp.gmail.com',
            :port                 => '587',
            :enable_starttls_auto => true,
            :user_name            => 'teamdietumd@gmail.com',
            :password             => pass,
            :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
            :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
          })
          logger.info "#{count}: Sent mail to #{user.name} at #{user.email} (over 50 users)."
      end  
    else
      users.each do |user|  
         this_subject = subject.gsub('#{user.name}', user.name)
         this_html = html_body.gsub('#{user.name}', user.name)
         this_body = body.gsub('#{user.name}', user.name)
        Pony.mail(:from => "#{name} <teamdietumd@gmail.com>", :to => user.email, :subject => this_subject, 
                  :html_body => this_html,
                  :body => this_body ,:via => :smtp, :via_options => {
            :address              => 'smtp.gmail.com',
            :port                 => '587',
            :enable_starttls_auto => true,
            :user_name            => 'teamdietumd@gmail.com',
            :password             => pass,
            :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
            :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
          })
          logger.info "Sent mail to #{user.name} at #{user.email} (under 50 users)"
          
      end
    end
      
    redirect_to admin_path, :notice => "Email successfully sent to group #{group} - #{current_user_id} - #{users.size}"
  end

  # GET /announcements/1
  # GET /announcements/1.xml
  def show
    @announcement = Announcement.find(params[:id])
    if current_user.group_id != 3
      redirect_to user_path(current_user), :notice => "Unauthorized User."
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @announcement }
    end
  end

  # GET /announcements/new
  # GET /announcements/new.xml
  def new
    @announcement = Announcement.new
    if current_user.group_id != 3
      redirect_to user_path(current_user), :notice => "Unauthorized User."
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @announcement }
    end
  end

  # GET /announcements/1/edit
  def edit
    @announcement = Announcement.find(params[:id])
    if current_user.group_id != 3
      redirect_to user_path(current_user), :notice => "Unauthorized User."
    end
    
  end

  # POST /announcements
  # POST /announcements.xml
  def create
    @announcement = Announcement.new(params[:announcement])
    if current_user.group_id != 3
      redirect_to user_path(current_user), :notice => "Unauthorized User."
    end

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to(@announcement, :notice => 'Announcement was successfully created.') }
        format.xml  { render :xml => @announcement, :status => :created, :location => @announcement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @announcement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /announcements/1
  # PUT /announcements/1.xml
  def update
    @announcement = Announcement.find(params[:id])
    if current_user.group_id != 3
      redirect_to user_path(current_user), :notice => "Unauthorized User."
    end

    respond_to do |format|
      if @announcement.update_attributes(params[:announcement])
        format.html { redirect_to(@announcement, :notice => 'Announcement was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @announcement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.xml
  def destroy
    if current_user.group_id != 3
      redirect_to user_path(current_user), :notice => "Unauthorized User."
    end
    @announcement = Announcement.find(params[:id])
    @announcement.destroy

    respond_to do |format|
      format.html { redirect_to(announcements_url) }
      format.xml  { head :ok }
    end
  end
end
