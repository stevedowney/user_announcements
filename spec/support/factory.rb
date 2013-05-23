module AnnouncementFactory
  
  def new_announcement(attributes={})
    Announcement.new_with_defaults.tap do |ann|
      ann.message = 'the message'
      ann.attributes = attributes
    end
  end
  
  def saved_announcement(attributes={})
    new_announcement(attributes).tap do |ann|
      ann.save!
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