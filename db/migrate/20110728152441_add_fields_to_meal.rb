class AddFieldsToMeal < ActiveRecord::Migration
  def self.up
    add_column :meals, :user_id, :integer
    add_column :meals, :servings, :integer
    add_column :meals, :date_eaten, :date
    add_column :meals, :location, :integer
    remove_column :meals, :price
    add_column :meals, :price, :decimal
    add_column :meals, :time_of_day, :integer
  end

  def self.down
    remove_column :meals, :time_of_day
    remove_column :meals, :price
    remove_column :meals, :location
    remove_column :meals, :date_eaten
    remove_column :meals, :servings
    remove_column :meals, :user_id
  end
end
