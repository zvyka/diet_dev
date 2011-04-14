class FoodsController < ApplicationController
  before_filter :authenticate
 
  def index
    @foods = Food.search(params[:search])
  end
  
  def show
    @foods = Food.find(params[:id])
    @title = @food.name
  end
  
end
