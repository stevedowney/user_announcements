# Class to handle fetching +Announcement+ rows for various use cases.
class AnnouncementFinder
  
  class << self
    
    # Returns all +Announcement+s for admin edit page.
    #
    # @return [ActiveRecord::Relation<Announcement>]
    def for_admin
      Announcement
        .all
        .sort_by(&:status_order)
    end
    
    # Returns unhidden +Announcement+s that _user_ may see.
    #
    # @param user [User]
    # @return [Array<Announcement>]
    def for_display(user)
      result = current
      result = remove_hidden(user, result)
      result = filter_by_role(user, result)
      result
    end
    
    # Returns +Announcement+s that _user_ may edit.
    #
    # @param user [User]
    # @return [ActiveRecord::Relation<Announcement>]
    def for_edit(user)
     Announcement
        .active
        .where("(starts_at is null or starts_at < :now)", :now => DateTime.now)
        .order('created_at desc')
    end
    
    private
    
    # Returns current +Announcement+s
    #
    # @return [ActiveRecord::Relation<Announcement>]
    def current
      Announcement
        .active
        .where("starts_at is null or starts_at < :now", now: DateTime.now)
        .where("ends_at is null or ends_at > :now", now: DateTime.now)
    end

    # Removes any +Announcement+s from _relation_ that _user_ has hidden.
    #
    # @param user [User]
    # @param relation [ActiveRecord::Relation<Announcement>]
    # @return [ActiveRecord::Relation<Announcement>]
    def remove_hidden(user, relation)
      hidden_announcement_ids = HiddenAnnouncement.hidden_announcement_ids_for(user.id)
      
      if hidden_announcement_ids.present?
        relation.where("id not in (?)", hidden_announcement_ids)
      else
        relation
      end
    end

    # Removes any +Announcement+s from _relation_ that _user_ can't see.
    #
    # @param user [User]
    # @param relation [ActiveRecord::Relation<Announcement>]
    def filter_by_role(user, relation)
      relation.select { |announcement| user_can_see(user, announcement.roles) }
    end
    
    # Returns +true+ if _user_ can see announcement based on _roles_.
    #
    # @param user [User, #has_role?]
    # @param roles [Array<String>]
    # @return [Boolean]
    def user_can_see(user, roles)
      puts "user_can_see: #{user.id} #{roles.inspect}"
      if roles.detect(&:blank?) || roles.blank?
        true
      else
        roles.any? { |role| user.has_role?(role) }
      end
    end
    
  end
  
end