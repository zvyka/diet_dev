class AddIdNumToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :id_num, :int
  end

  def self.down
    remove_column :users, :id_num
  end
end
