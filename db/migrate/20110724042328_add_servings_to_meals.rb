class AddServingsToMeals < ActiveRecord::Migration
  def self.up
    add_column :meals, :servings, :integer
  end

  def self.down
    remove_column :meals, :servings
  end
end
