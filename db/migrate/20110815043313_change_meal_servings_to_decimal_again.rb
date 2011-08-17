class ChangeMealServingsToDecimalAgain < ActiveRecord::Migration
  def self.up
    change_column :ingredients, :servings, :decimal, :precision => 4, :scale => 2
  end

  def self.down
    change_column :ingredients, :servings, :integer
  end
end
