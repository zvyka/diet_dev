class ChangeMealServingsToDecimal < ActiveRecord::Migration
  def self.up
    change_column :ingredients, :servings, :decimal
  end

  def self.down
    change_column :ingredients, :servings, :integer
  end
end
