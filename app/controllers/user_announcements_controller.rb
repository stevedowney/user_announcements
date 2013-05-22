class UserAnnouncementsController < ApplicationController
  before_filter :ensure_current_user
  
  def index
    @announcements = AnnouncementFinder.past_or_current
    @hidden_announcement_ids = UserAnnouncement.hidden_announcement_ids_for(current_user.id)
  end
  
  def hide
    @announcement_id = params.fetch(:id)
    UserAnnouncement.create_for(current_user, @announcement_id)
  end
  
  def unhide
    UserAnnouncement.delete_all(user_id: current_user.id, announcement_id: params.fetch(:id))
    redirect_to action: 'index'
  end
  
  private
  
  def ensure_current_user
  rescue NameError
    raise "You must have a current_user method"
  end
  
end