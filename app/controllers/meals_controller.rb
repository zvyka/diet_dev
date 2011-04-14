class MealsController < ApplicationController
  before_filter :authenticate
  
  def create
    @meal.destroy
    redirect_back_or root_pat
  end

  def destroy
  end
  
  private
    def authorized_user
      @meal = Meal.find(params[:id])
      redirect_to root_path unless current_user?(@meal.user)
    end
  
end
