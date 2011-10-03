class FoodsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :authenticate
  
  include ActionView::Helpers::SanitizeHelper
  
  def index
    @foods = Food.search('"^' + params[:term] + '"|"' + params[:term] + '"|(' + params[:term] + ')', :match_mode => :extended2, :excerpts => false, :per_page => 100, :order => :umd, :sort_mode => :desc)
    respond_to do |format|
      format.html
      format.json do 
             # make an array
             @foods.map! do |u| 
               {
                   :food_id => u.id,
                   :value => u.user_id == @user.id || u.user_id.nil? ? (u.nil? ? "" : strip_tags(u.name)) : nil,
                   :grams => u.weight_1_gms,
                   :serving => u.weight_1_desc,
                   :umd => u.umd
               }
             end
             render :json => @foods 
           end
    end
  end

  def show
    @food = Food.find(params[:id])
    if @food.user_id.nil? or @food.user_id == current_user.id  
      @dvs = {:total_fat => 65, :fa_sat => 20, :cholesterol => 300, :sodium => 2400, :potassium => 3500,
              :tot_carbs => 300, :fiber => 25, :protein => 50, :vit_c => 60, :calcium => 1000, :iron => 18, 
              :sugar_total => 40}
    else
      # puts current_user.id
      redirect_to root_path
    end
    
  end

  def search
      query = params[:search].nil? ? nil : params[:search].gsub(/[\+\-\"\/\\]/,'')
      if !query.nil? 
        if params[:search].blank?
          redirect_to food_search_path 
        else
          @foods = Food.search('"^' + query + '"|"' + query + '"|(' + query + ')', :match_mode => :extended2, :excerpts => false, :per_page => 100, :order => :umd, :sort_mode => :desc)
        end
      else 
        @foods = Food.find_all_by_user_id(current_user.id) 
      end
      
  end
  
  def new
    @food = Food.new
  end

  def create
    @food = Food.new(params[:food])
    if @food.save
      redirect_to @food, :notice => "Successfully created food."
    else
      render :action => 'new'
    end
  end

  def edit
    @food = Food.find(params[:id])
    if @food.user_id != @user.id
      redirect_to @food
    end
  end

  def update
    @food = Food.find(params[:id])
    if @food.update_attributes(params[:food])
      redirect_to @food, :notice  => "Successfully updated food."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to myfoods_path, :notice => "Successfully destroyed food."
  end
end
