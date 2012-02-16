class ChangeFruitsAndVegetablesToBooleanInIngredients < ActiveRecord::Migration
  def self.up
    change_column :ingredients, :fruits_and_vegetables, :boolean
  end

  def self.down
    change_column :ingredients, :fruits_and_vegetables
  end
end
