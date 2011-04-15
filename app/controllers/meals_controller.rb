class MealsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  
  def home
    @title = "Home"
    @meal = Meal.new if signed_in?
    @foods = Food.search(params[:search])
  end
  
  def create
    @foods = Food.search(params[:search])
    @meal  = current_user.meals.build(params[:meal])
    @meal.update_attributes(params[:meal])
    if @meal.save
      flash[:success] = "Meal saved!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def destroy
  end
  
  private
    def authorized_user
      @meal = Meal.find(params[:id])
      redirect_to root_path unless current_user?(@meal.user)
    end
  
end
