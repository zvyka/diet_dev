class AddFaveNameToMeals < ActiveRecord::Migration
  def self.up
    add_column :meals, :fave_name, :string
  end

  def self.down
    remove_column :meals, :fave_name
  end
end
