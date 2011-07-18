class RemoveServingSizeFromMeals < ActiveRecord::Migration
  def self.up
    remove_column :meals, :serving_size
  end

  def self.down
    add_column :meals, :serving_size, :integer
  end
end
