class Announcement < ActiveRecord::Base
  attr_accessible :body, :starts_at, :ends_at, :active

  has_many :user_announcements, :dependent => :destroy
  
  validates_presence_of :body, :starts_at, :ends_at
  

  PAST = 'past'
  CURRENT = 'current'
  FUTURE = 'future'
  
  def status
    case
    when ends_at.try(:past?) then PAST
    when starts_at.try(:future?) then FUTURE
    else CURRENT
    end
  end
  
  def current?
    status == CURRENT
  end
  
  def status_order
    { FUTURE => 1, CURRENT => 2, PAST => 3 }[status]
  end
  
  class << self

    def new_with_defaults
      new do |ann|
        ann.active = true
        ann.starts_at = Time.now.at_beginning_of_day
        ann.ends_at = 1.week.from_now.at_midnight
      end

    end

  end
end
