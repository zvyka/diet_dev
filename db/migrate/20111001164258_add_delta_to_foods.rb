class AddDeltaToFoods < ActiveRecord::Migration
  def self.up
    add_column :foods, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :foods, :delta
  end
end
