class MealsController < ApplicationController
  
  before_filter CASClient::Frameworks::Rails::Filter

    before_filter :authenticate, :only => [:create, :destroy]

    def index
      redirect_to user_path(current_user)
    end

  def show
    @meal = Meal.find(params[:id])
    @foods = Food.all
  end

  def new
    @meal = Meal.new
    @foods = Food.all
    
    s_keys = "{ "
    @foods.map do |x|
      s_keys += "#{x.name}:#{x.weight_1_desc}:#{x.weight_1_gms}|"
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

    s_keys = "{ "
    @foods.map do |x|
      s_keys += "#{x.name}:#{x.weight_1_desc}:#{x.weight_1_gms}|"
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
    redirect_to user_path(current_user), :notice => "Successfully destroyed meal."
  end
end
