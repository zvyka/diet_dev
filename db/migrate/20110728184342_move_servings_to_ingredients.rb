class MoveServingsToIngredients < ActiveRecord::Migration
  def self.up
    remove_column :meals, :servings
    add_column :ingredients, :servings, :integer
  end

  def self.down
    remove_column :ingredients, :servings
    add_column :meals, :servings, :integer
  end
end
