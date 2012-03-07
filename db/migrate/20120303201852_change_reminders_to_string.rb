class ChangeRemindersToString < ActiveRecord::Migration
  def self.up
    change_column :users, :reminder_freq, :string
  end

  def self.down
    change_column :users, :reminder_freq
  end
end
