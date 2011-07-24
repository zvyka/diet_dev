class AnnouncementsController < ApplicationController
  # GET /announcements
  # GET /announcements.xml
  def index
    @announcements = Announcement.all
    if current_user.UID != "jindig"
      redirect_to user_path(current_user), :notice => "Unauthorized User."
    end
      
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @announcements }
    end
  end

  # GET /announcements/1
  # GET /announcements/1.xml
  def show
    @announcement = Announcement.find(params[:id])
    if current_user.UID != "jindig"
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
    if current_user.UID != "jindig"
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
    if current_user.UID != "jindig"
      redirect_to user_path(current_user), :notice => "Unauthorized User."
    end
    
  end

  # POST /announcements
  # POST /announcements.xml
  def create
    @announcement = Announcement.new(params[:announcement])
    if current_user.UID != "jindig"
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
    if current_user.UID != "jindig"
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
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    if current_user.UID != "jindig"
      redirect_to user_path(current_user), :notice => "Unauthorized User."
    end

    respond_to do |format|
      format.html { redirect_to(announcements_url) }
      format.xml  { head :ok }
    end
  end
end
