class FoodsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :authenticate
  
  include ActionView::Helpers::SanitizeHelper
  
  def index
    food_search = Food.search('"^' + params[:term] + '"|"' + params[:term] + '"|(' + params[:term] + ')', :match_mode => :extended2, :excerpts => false, :per_page => 100, :order => :umd, :sort_mode => :desc)
    
    @foods = food_search.find_all{|food| food.user_id==nil || food.user_id==current_user.id}
    
    respond_to do |format|
      format.html
      format.json do 
             # make an array
             @foods.map! do |u| 
               {
                   :food_id => u.id.nil? ? 0 : u.id,
                   :value => u.user_id.nil? ? (u.nil? ? "" : strip_tags(u.name)) : strip_tags(u.name),
                   :grams => u.weight_1_gms.nil? ? 0 : u.weight_1_gms ,
                   :serving => u.weight_1_desc.nil? ? 0 : u.weight_1_desc,
                   :umd => u.umd.nil? ? 0 : u.umd
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
          food_search = Food.search('"^' + query + '"|"' + query + '"|(' + query + ')', :match_mode => :extended2, :excerpts => false, :per_page => 100, :order => :umd, :sort_mode => :desc)
          @foods = food_search.find_all{|food| food.user_id==nil || food.user_id==current_user.id}
        end
      else 
        @foods = Food.find_all_by_user_id(current_user.id) 
      end
      
  end
  
  def new
    @food = Food.new
  end

  def create
    calcium = (params[:food][:calcium].to_f*1000)/100
    iron = (params[:food][:iron].to_f*18)/100
    vit_c = (params[:food][:vit_c].to_f*60)/100
    
    params[:food][:calcium] = calcium
    params[:food][:calcium] = iron
    params[:food][:calcium] = vit_c
    
    @food = Food.new(params[:food])
    if @food.save
      redirect_to @food, :notice => "Successfully created food."
    else
      render :action => 'new'
    end
  end

  def edit
    @food = Food.find(params[:id])    
    if @food.user_id != current_user.id
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
    Ingredient.find_all_by_food_id(@food.id).each do |i|
      m_id = i.meal_id
      i.delete
      if Ingredient.find_by_meal_id(m_id).nil?
        Meal.find_by_id(m_id).destroy
      end
    end
    @food.destroy
    redirect_to myfoods_path, :notice => "Successfully destroyed food."
  end
end
