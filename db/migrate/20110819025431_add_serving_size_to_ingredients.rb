class AddServingSizeToIngredients < ActiveRecord::Migration
  def self.up
    add_column :ingredients, :serving_size, :decimal, :precision => 4, :scale => 2
  end

  def self.down
    remove_column :ingredients, :serving_size
  end
end
