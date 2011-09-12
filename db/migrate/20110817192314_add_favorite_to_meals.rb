class AddFavoriteToMeals < ActiveRecord::Migration
  def self.up
    add_column :meals, :favorite, :boolean
  end

  def self.down
    remove_column :meals, :favorite
  end
end
