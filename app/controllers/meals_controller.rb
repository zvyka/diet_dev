class MealsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  
  before_filter :authenticate, :only => [:create, :destroy]
  # auto_complete_for :foods, :name
  
  def index
    # @meals = Meal.find(:all)
    #     @date = params[:month] ? Date.parse(params[:month]) : Date.today
    redirect_to user_path(current_user)
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new
    # @foods = Food.search(params[:search]) if !params[:search].nil?
  end
  
  def edit
    @meal = Meal.find(params[:id])
  end
  
  def home
    @title = "Home"
    @meal = Meal.new if signed_in?
    @foods = Food.search(params[:search]) if !params[:search].nil?
  end
  
  def create
    # @foods = Food.search(params[:search])
    # @meal  = current_user.meals.build(params[:meal])
    # @meal.update_attributes(params[:meal]) 
    @meal = Meal.new(params[:meal])
    if @meal.save
      flash[:success] = "Meal saved!"
      redirect_to user_path(current_user)
    else
      render 'pages/home'
    end
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
      redirect_to user_path(current_user), :notice => "Successfully deleted meal."
    end
  
  private
    def authorized_user
      @meal = Meal.find(params[:id])
      redirect_to root_path unless current_user?(@meal.user)
    end
  
end
