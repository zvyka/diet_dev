class ChangeIdToFoodIdInFoods < ActiveRecord::Migration
  def self.up
    rename_column :foods, :id, :food_id
  end

  def self.down
    rename_column :foods, :food_id, :id
  end
end
