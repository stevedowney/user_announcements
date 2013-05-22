class AnnouncementFinder
  
  class << self
    
    def ordered
      Announcement.all.sort_by(&:status_order)
    end
    
    def current
      Announcement
        .active
        .where("starts_at is null or starts_at < :now", now: DateTime.now)
        .where("ends_at is null or ends_at > :now", now: DateTime.now)
    end
    
    def past_or_current
      Announcement
        .active
        .where("(starts_at is null or starts_at < :now)", :now => DateTime.now)
        .order('created_at desc')
    end
    
    def current_for_user(user)
      for_user(user, current)
    end
    
    # def past_or_current_for_user(user)
    #   # FIXME: apply roles
    #   past_or_current
    # end
    
    def for_user(user, type)
      hidden_announcement_ids = UserAnnouncement.hidden_announcement_ids_for(user.id)
      result = type
      result = result.where("id not in (?)", hidden_announcement_ids) if hidden_announcement_ids.present?
      result.sort_by(&:status_order)
    end
  end
  
end