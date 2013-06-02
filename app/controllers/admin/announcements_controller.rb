class Admin::AnnouncementsController < ApplicationController

  before_filter :ensure_admin_user
  before_filter :find_announcement, :only => [:edit, :update, :destroy]

  def index
    @announcements = AnnouncementFinder.for_admin
  end
  
  def new
    @announcement = Announcement.new_with_defaults
  end
  
  def edit
  end
  
  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      redirect_to admin_announcements_path, :flash => { notice: 'Announcement created'}
    else
      render "new"
    end
  end
  
  def update
    @announcement.attributes = announcement_params
    @announcement.roles = [] unless announcement_params.has_key?(:roles)  
    if @announcement.save
      redirect_to admin_announcements_path, :flash => { notice: 'Announcement updated' }
    else
      render "edit"
    end
  end
  
  def destroy
    @announcement.destroy
    redirect_to admin_announcements_path, :flash => { notice: 'Announcement deleted' }
  end

  private

  def find_announcement
    @announcement = Announcement.find(params.fetch(:id))
  end
  
  def announcement_params
    if defined?(StrongParameters)
      params.require(:announcement).permit(
       :active,
       :message,
       :starts_at,
       :"starts_at(1i)",
       :"starts_at(2i)",
       :"starts_at(3i)",
       :"starts_at(4i)",
       :"starts_at(5i)",
       :ends_at,
       :"ends_at(1i)",
       :"ends_at(2i)",
       :"ends_at(3i)",
       :"ends_at(4i)",
       :"ends_at(5i)",
       :style,
       {:roles => []},
       :type,
      )
    else
      params.fetch(:announcement)
    end
  end
end
