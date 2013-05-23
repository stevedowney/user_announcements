class Announcement < ActiveRecord::Base
  attr_accessible :message, :starts_at, :ends_at, :active

  has_many :hidden_announcements, :dependent => :destroy
  
  validates_presence_of :message, :starts_at, :ends_at
  
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
  
  def status_order
    { FUTURE => 1, CURRENT => 2, PAST => 3, INACTIVE => 4 }[status]
  end
  
  class << self

    def active
      where(active: true)
    end
    
    def new_with_defaults
      new do |ann|
        ann.active = get_default(:active)
        ann.starts_at = get_default(:starts_at)
        ann.ends_at = get_default(:ends_at)
      end
    end
    
    private
    
    def get_default(column)
      config_key = "default_#{column}"
      default = UserAnnouncements.config.send(config_key)
      
      if default.is_a?(Proc)
        default.call
      else
        default
      end
    end

  end
end
