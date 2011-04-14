class AddIdToFoods < ActiveRecord::Migration
  def self.up
      add_column :foods, :meal_id, :integer
      add_index :foods, :meal_id
    end

    def self.down
      remove_column :users, :admin
    end
end
