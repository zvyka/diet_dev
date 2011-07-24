class AddDefaultServings < ActiveRecord::Migration
  def self.up
    remove_column :meals, :servings
    add_column :meals, :servings, :integer, :default => 0
  end

  def self.down
    remove_column :meals, :servings
  end
end
