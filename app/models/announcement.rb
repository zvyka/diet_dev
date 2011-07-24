class Announcement < ActiveRecord::Base
  def self.current_announcements()
    find(:all, :conditions => "starts_at <= now() AND ends_at >= now()")
  end
end
