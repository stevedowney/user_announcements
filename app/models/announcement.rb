class Announcement < ActiveRecord::Base
  serialize :roles, class_name = Array
  serialize :types, class_name = Array
  
  attr_accessible :message, :starts_at, :ends_at, :active, :roles, :style

  has_many :hidden_announcements, :dependent => :destroy
  
  validates_presence_of :message
  
  INACTIVE = 'inactive'
  PAST = 'past'
  CURRENT = 'current'
  FUTURE = 'future'
  
  def status
    case
    when active.presence.nil? then INACTIVE
    when ends_at.try(:past?) then PAST
    when starts_at.try(:future?) then FUTURE
    else CURRENT
    end
  end
  
  def current?
    status == CURRENT
  end
  
  def starts_at_for_user
    starts_at || created_at
  end
  
  def status_order
    { FUTURE => 1, CURRENT => 2, PAST => 3, INACTIVE => 4 }[status]
  end
  
  class << self

    def active
      where(active: true)
    end
    
    def new_with_defaults
      new do |ann|
        ann.active = UserAnnouncements[:default_active]
        ann.starts_at = UserAnnouncements[:default_starts_at]
        ann.ends_at = UserAnnouncements[:default_ends_at]
        ann.roles = Array(UserAnnouncements[:default_roles])
        ann.style = UserAnnouncements[:default_style]
      end
    end
    
  end
end
