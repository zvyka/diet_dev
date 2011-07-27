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
   @ingredient = @meal.ingredients.build
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
    
    # params[:meal][:ingredients_attributes][:food_tokens] = params[:meal][:food_tokens]
    @all_values = ""
    @all_values = get_all_values_nested(params[:meal])
    @meal = Meal.new(params[:meal])
    @ingredients = @meal.ingredients.build(:food_id => @all_values)
    if @meal.save
      flash[:success] = "Meal saved!"
      redirect_to user_path(current_user) #user_path(current_user)
    else
      render 'pages/home'
    end
  end

  def update       
      @meal = Meal.find(params[:id])
      if @meal.update_attributes(params[:meal])
        redirect_to user_path(current_user), :notice  => "Successfully updated meal."
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
    
    def get_all_values_nested(nested_hash={}) 
      nested_hash.each_pair do |k,v|
        case v
          when String, Fixnum then @all_values << v  if k == "food_id"
          when Hash then get_all_values_nested(v)
          else raise ArgumentError, "Unhandled type #{v.class}"
        end
      end
      return @all_values
    end
    
end
