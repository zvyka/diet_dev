class AddUserIdToFoods < ActiveRecord::Migration
  def self.up
    add_column :foods, :user_id, :integer
  end

  def self.down
    remove_column :foods, :user_id
  end
end
