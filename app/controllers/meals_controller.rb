class MealsController < ApplicationController
  
  before_filter CASClient::Frameworks::Rails::Filter

    before_filter :authenticate, :only => [:create, :destroy]

    def index
      redirect_to user_path(current_user)
    end

  def show
    @meal = Meal.find(params[:id])
    @foods = Food.all
    
    @dvs = {:total_fat => 65, :sat_fat => 20, :cholesterol => 300, :sodium => 2400, :potassium => 3500, :tot_carbs => 300, :fiber => 25, 
            :protein => 50, :vit_c => 60, :calcium => 1000, :iron => 18}   
            
    if @meal.user_id != current_user.id
      redirect_to user_path(current_user), :notice => "Access denied"
    end         
  end

  def new
    @meal = Meal.new
    @foods = Food.all
  end

  def create
    @meal = Meal.new(params[:meal])
    if @meal.save
      redirect_to @meal, :notice => "Successfully created meal."
    else
      redirect_to new_meal_path, :notice => "Food can't be blank!"
    end
  end

  def edit
    @meal = Meal.find(params[:id])
    @foods = Food.all
    
    if @meal.user_id != current_user.id
      redirect_to user_path(current_user), :notice => "Access denied"
    end
  end

  def update
    @meal = Meal.find(params[:id])
    if @meal.update_attributes(params[:meal])
        redirect_to @meal, :notice  => "Successfully updated meal."
    else
      # render :action => 'edit'
      redirect_to edit_meal_path(@meal), :notice => "Food can't be blank!"
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
