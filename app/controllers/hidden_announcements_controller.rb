class HiddenAnnouncementsController < ApplicationController
  before_filter :ensure_current_user
  
  def index
    @announcements = AnnouncementFinder.past_or_current
    @hidden_announcement_ids = HiddenAnnouncement.hidden_announcement_ids_for(current_user.id)
  end
  
  def create
    @announcement_id = params.fetch(:announcement_id)
    HiddenAnnouncement.create_for(current_user.id, @announcement_id)
  end
  
  def destroy
    HiddenAnnouncement.delete_all(user_id: current_user.id, announcement_id: params.fetch(:announcement_id))
    redirect_to action: 'index'
  end
  
end