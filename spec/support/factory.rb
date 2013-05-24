module AnnouncementFactory
  
  def new_current_announcement
    Announcement.new_with_defaults.tap do |ann|
      ann.message = 'current'
      ann.starts_at = 1.day.ago
      ann.ends_at = 1.day.from_now
    end
  end
  
  def saved_current_announcement
    new_current_announcement.tap do |a|
      a.save!
    end
  end
  
  def saved_past_announcement
    new_current_announcement.tap do |a|
      a.message = 'past'
      a.ends_at = 1.day.ago
      a.save!
    end
  end
  
  def saved_future_announcement
    new_current_announcement.tap do |a|
      a.message = 'future'
      a.starts_at = 1.day.from_now
      a.save!
    end
  end
  
  def saved_inactive_announcement
    new_current_announcement.tap do |a|
      a.active = false
      a.save!
    end
  end
  
  def saved_user(attributes={})
    User.new.tap do |user|
      user.name = 'user-name'
      user.save!
    end
  end
  
end

RSpec.configure { |c| c.include AnnouncementFactory }