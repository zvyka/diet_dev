class ChangeFoodIdToStringAndPluralize < ActiveRecord::Migration
  def self.up
    rename_column :meals, :food_id, :food_ids
    change_column :meals, :food_ids, :string
  end

  def self.down
    change_column :meals, :food_ids, :integer
    rename_column :meals, :food_ids, :food_id
  end
end