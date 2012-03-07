class AddWeightToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :weight, :int
  end

  def self.down
    remove_column :users, :weight
  end
end
