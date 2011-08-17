class ChangeFoodIdIncrement < ActiveRecord::Migration
  def self.up
    remove_column :foods, :id
    add_column :foods, :id, :primary_key 
  end

  def self.down
  end
end
