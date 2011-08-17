class AddFoodIdToIngredients < ActiveRecord::Migration
  def self.up
      add_column :ingredients, :food_id, :integer
    end

    def self.down
      remove_column :ingredients, :food_id
    end
end
