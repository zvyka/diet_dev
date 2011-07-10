class ChangeIncrementInFoods < ActiveRecord::Migration
  def self.up
    rename_column :foods, :increment, :incr
    
  end

  def self.down
    rename_column :foods, :incr, :increment
    
  end
end