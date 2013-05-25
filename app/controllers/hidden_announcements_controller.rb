class HiddenAnnouncementsController < ApplicationController
  before_filter :ensure_current_user
  
  def index
    @announcements = AnnouncementFinder.for_edit(current_user)
    @hidden_announcement_ids = HiddenAnnouncement.hidden_announcement_ids_for(current_user.id)
  end
  
  def create
    @announcement_id = params.fetch(:announcement_id)
    HiddenAnnouncement.create_for(current_user.id, @announcement_id)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
  
  def destroy
    HiddenAnnouncement.delete_all(user_id: current_user.id, announcement_id: params.fetch(:announcement_id))
    redirect_to action: 'index'
  end
  
end