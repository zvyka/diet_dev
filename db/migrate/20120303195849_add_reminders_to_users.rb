class AddRemindersToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :reminder_freq, :int, :default => 0
  end

  def self.down
    remove_column :users, :reminder_freq
  end
end
