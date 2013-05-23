class HiddenAnnouncement < ActiveRecord::Base
  attr_accessible :user_id, :announcement_id
  
  validates_presence_of :user_id, :announcement_id
  
  class << self
    
    def hidden_announcement_ids_for(user_id)
      where(user_id: user_id).pluck(:announcement_id)
    end
    
    def create_for(user_id, announcement_id)
      return if record_exists_for?(user_id, announcement_id)
      
      create!(
        user_id: user_id,
        announcement_id: announcement_id
      )
    end
    
    private
    
    def record_exists_for?(user_id, announcement_id)
      where(user_id: user_id, announcement_id: announcement_id).count > 0
    end
  end
  
end