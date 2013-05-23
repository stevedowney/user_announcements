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
  
  private
  
  def ensure_current_user
  rescue NameError
    raise "You must have a current_user method"
  end
  
end