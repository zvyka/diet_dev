class ChangeMealsIdsBack < ActiveRecord::Migration
  def self.up
    change_column :meals, :food_ids, :integer
    rename_column :meals, :food_ids, :food_id
  end
  
  def self.down
    rename_column :meals, :food_id, :food_ids
    change_column :meals, :food_ids, :string
  end
end
