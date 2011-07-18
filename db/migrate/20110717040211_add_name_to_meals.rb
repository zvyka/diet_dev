class AddNameToMeals < ActiveRecord::Migration
  def self.up
    add_column :meals, :name, :string
  end

  def self.down
    remove_column :meals, :name
  end
end
