class UserAnnouncement < ActiveRecord::Base
  attr_accessible :user_id, :announcement_id
  
  class << self
    
    def hidden_announcement_ids_for(user_id)
      where(user_id: user_id).pluck(:announcement_id)
    end
    
    def create_for(current_user, announcement_id)
      create!(
        user_id: current_user.id,
        announcement_id: announcement_id
      )
    end
    
  end
  
end