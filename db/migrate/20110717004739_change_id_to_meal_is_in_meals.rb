class ChangeIdToMealIsInMeals < ActiveRecord::Migration
  def self.up
    rename_column :meals, :id, :meal_id
  end

  def self.down
    rename_column :meals, :meal_id, :id
  end
end
