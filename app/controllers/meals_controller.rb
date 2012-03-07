class MealsController < ApplicationController
  
  before_filter CASClient::Frameworks::Rails::Filter

    before_filter :authenticate, :only => [:create, :destroy]

    def index
      redirect_to user_path(current_user)
    end

  def show
    @meal = Meal.find(params[:id])
        
    @meal.ingredients.build :what_food => "_new_food"
    @meal.ingredients.sort! { |a,b| a.what_food.downcase <=> b.what_food.downcase }
    @meal.ingredients[0].what_food = nil
        
    @foods = Food.all
    
    @dvs = {:total_fat => 65, :fa_sat => 20, :cholesterol => 300, :sodium => 2400, :potassium => 3500,
            :tot_carbs => 300, :fiber => 25, :protein => 50, :vit_c => 60, :calcium => 1000, :iron => 18, 
            :sugar_total => 40, :calories => 2000, :f_and_vs => 5}   
            
    @todays_meals = Meal.search(@meal.date_eaten, @meal.user_id).order("time_of_day")
    
     @cals = 0 
  	 @salt = 0 
  	 @fats = 0 
  	 @sugs = 0 
  	 @f_and_vs = 0 
  	 for individual_meal in @todays_meals do 
  		 for ingredient in individual_meal.ingredients do 
  			 if ingredient.fruits_and_vegetables == true 
  				 @f_and_vs = @f_and_vs + 1*ingredient.servings 
  			 end 
  			 food = Food.find(ingredient.food_id) 
  			 if ingredient.serving_size.nil? 
  				 multiplication_factor = ingredient.servings
  			 else 
  				 multiplication_factor = ingredient.servings*ingredient.serving_size/100
  			 end 
  			 @cals = @cals + (food.calories*multiplication_factor) 
  			 @salt = @salt + (food.sodium*multiplication_factor) 
  			 @fats = @fats + (food.lipid_total*multiplication_factor) 
  			 @sugs = @sugs + (food.sugar_total*multiplication_factor) 
  		 end 
  	 end 	
            
      @chart_data = "#{'%1.2f' % (100*@cals/@dvs[:calories])}, #{'%1.2f' % (100*@salt/@dvs[:sodium])}, #{'%1.2f' % (100*@fats/@dvs[:total_fat])}, #{'%1.2f' % (100*@sugs/@dvs[:sugar_total])}, #{'%1.2f' % (100*@f_and_vs/@dvs[:f_and_vs])}"
            
    if @meal.user_id != current_user.id
      redirect_to user_path(current_user), :notice => "Access denied"
    end         
  end
  
  def new
    @meal = Meal.new
    @foods = Food.all
    
    @meal.ingredients.build
  end

  def create
    @meal = Meal.new(params[:meal])
    if @meal.save
      redirect_to @meal, :success => "Successfully created meal."
    else
      flash[:error] = "Oops, something didn't work! Remember, your food can't be blank, and you can't have more than one meal on any day. See the #{ActionController::Base.helpers.link_to "Help page", help_path} for more details".html_safe
      redirect_to user_path(current_user)#, :success => "Food can't be blank! Make sure you select a food from the list. See the #{ActionController::Base.helpers.link_to "Help page", help_path} for more details".html_safe
    end
  end

  def edit
    @meal = Meal.find(params[:id])
    
    @foods = Food.all
        
    if @meal.user_id != current_user.id
      redirect_to user_path(current_user), :warning => "Access denied"
    end
  end
  
  def make_clone
    old_meal = Meal.find(params[:id])
    new_meal = old_meal.clone :include => :ingredients
    new_meal.favorite = false
    new_meal.date_eaten = Date.today
    new_meal.save
    redirect_to edit_meal_path(new_meal), :notice => "Edit your duplicated meal here"
  end

  def update
    @meal = Meal.find(params[:id])
    if @meal.update_attributes(params[:meal])
        @this_meal.destroy
        redirect_to @meal, :success  => "Successfully updated meal."
    else
      # render :action => 'edit'
      redirect_to @meal, :error => "Oops, something didn't work! Remember, your food can't be blank, and you can't have more than one meal on any day. See the #{ActionController::Base.helpers.link_to "Help page", help_path} for more details".html_safe
    end 
    
  end

  def destroy
    @meal = Meal.find(params[:id])
    if @meal.user_id != current_user.id
      redirect_to user_path(current_user), :notice => "Access denied"
    end
    @meal.destroy
    redirect_to user_path(current_user), :notice => "Successfully destroyed meal."
  end
end
