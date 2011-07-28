class ChangeWhatfoodToString < ActiveRecord::Migration
  def self.up
    change_column :ingredients, :what_food, :string
  end

  def self.down
    change_column :ingredients, :what_food, :integer
  end
end
