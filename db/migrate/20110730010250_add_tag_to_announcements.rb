class AddTagToAnnouncements < ActiveRecord::Migration
  def self.up
    add_column :announcements, :tag, :string
  end

  def self.down
    remove_column :announcements, :tag
  end
end
