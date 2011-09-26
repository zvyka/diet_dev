class FoodsController < ApplicationController
  before_filter :authenticate
  
  def index
    @foods = Food.search('"^' + params[:term] + '"|"' + params[:term] + '"|(' + params[:term] + ')', :match_mode => :extended2, :excerpts => false, :per_page => 100, :order => :umd, :sort_mode => :desc)
    respond_to do |format|
      format.html
      format.json do 
             # make an array
             @foods.map! do |u| 
               {
                 :food_id => u.id,
                 :value => u.name,
                 :grams => u.weight_1_gms,
                 :serving => u.weight_1_desc,
                 :umd => u.umd
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
