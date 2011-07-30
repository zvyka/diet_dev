class FoodsController < ApplicationController
  before_filter :authenticate
  
  def index
    # @foods = Food.where("name like ?", "%#{params[:q]}%")
    @foods = Food.search params[:term], :match_mode => :all, :excerpts => false
    respond_to do |format|
      format.html
      # format.json { render :json => @foods.map(&:attributes) }
      #       format.js { render :json => @foods.map(&:name)}
      format.json do 
             # make an array
             @foods.map! do |u| 
               {
                 # :name => u.name,
                 :value => u.name
               }
             end
             render :json => @foods 
           end
    end
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(params[:food])
    if @food.save
      redirect_to @food, :notice => "Successfully created food."
    else
      render :action => 'new'
    end
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    if @food.update_attributes(params[:food])
      redirect_to @food, :notice  => "Successfully updated food."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_url, :notice => "Successfully destroyed food."
  end
end
