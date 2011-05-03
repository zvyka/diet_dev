class AddPriceLocationTimeDataToMeals < ActiveRecord::Migration
  def self.up
    add_column :meals, :price, :decimal, :precision => 8, :scale => 2
    add_column :meals, :location, :integer
    add_column :meals, :date, :date
    add_column :meals, :time_of_day, :integer
  end

  def self.down
    remove_column :meals, :time_of_day
    remove_column :meals, :date
    remove_column :meals, :location
    remove_column :meals, :price
  end
end
