class AddReadyToAnnouncements < ActiveRecord::Migration
  def self.up
    add_column :announcements, :ready, :int
  end

  def self.down
    remove_column :announcements, :ready
  end
end
