class Announcement < ActiveRecord::Base 
  def self.get_current_announcements()
    find(:all, :conditions => ['starts_at <= ? and ends_at >= ? and ready > ?', Time.now, Time.now, 0], :order => 'starts_at DESC')
  end
  
  def self.get_current_and_previous_announcements()
    find(:all, :conditions => ['starts_at <= ? and ready > ?', Time.now, 0], :order => 'starts_at DESC')
  end
end
