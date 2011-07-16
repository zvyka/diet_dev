class FoodsController < ApplicationController
  before_filter :authenticate
  helper_method :sort_column, :sort_direction
  
  def index
    #@foods = Food.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
    @foods = Food.search(params[:search])
    
    @meal = Meal.new if signed_in?
  end
  
  def show
    @foods = Food.search(params[:search])
     #@foods = Food.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
    @meal = Meal.new if signed_in?
  end
  
  private
  
  def sort_column
    Meal.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
