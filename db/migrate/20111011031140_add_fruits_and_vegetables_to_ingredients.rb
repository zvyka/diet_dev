class AddFruitsAndVegetablesToIngredients < ActiveRecord::Migration
  def self.up
    add_column :ingredients, :fruits_and_vegetables, :integer, :default => 0
  end

  def self.down
    remove_column :ingredients, :fruits_and_vegetables
  end
end
