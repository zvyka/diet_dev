class FixIdStuff < ActiveRecord::Migration
  
  def self.up
    remove_column :meals, :meal_id
    remove_column :foods, :food_id
  end
  
  def self.down
    add_column :meals, :meal_id
    add_column :foods, :food_id
  end
end
