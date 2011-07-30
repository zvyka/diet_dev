class MealsController < ApplicationController
  
  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(params[:id])
    @foods = Food.all
  end

  def new
    @meal = Meal.new
    @foods = Food.all
    @keys = @foods.map { |x| x.name }
    @autocomplete_foods = @keys.to_json.html_safe
    
    s_keys = "{ "
    @foods.map do |x|
      s_keys += "#{x.name}:#{x.weight_1_desc}|"
    end
    s_keys += "}"
    @food_array = s_keys 
  end

  def create
    @meal = Meal.new(params[:meal])
    if @meal.save
      redirect_to @meal, :notice => "Successfully created meal."
    else
      render :action => 'new'
    end
  end

  def edit
    @meal = Meal.find(params[:id])
    @foods = Food.all
    @keys = @foods.map { |x| x.name }
    @autocomplete_foods = @keys.to_json.html_safe

    s_keys = "{ "
    @foods.map do |x|
      s_keys += "#{x.name}:#{x.weight_1_desc}|"
    end
    s_keys += "}"
    @food_array = s_keys
  end

  def update
    @meal = Meal.find(params[:id])
    if @meal.update_attributes(params[:meal])
      redirect_to @meal, :notice  => "Successfully updated meal."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    redirect_to meals_url, :notice => "Successfully destroyed meal."
  end
end
