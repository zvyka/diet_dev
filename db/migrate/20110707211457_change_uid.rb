class ChangeUid < ActiveRecord::Migration
  def self.up
    change_column :users, :UID, :string
  end

  def self.down
    change_column :users, :UID, :integer
  end
end
