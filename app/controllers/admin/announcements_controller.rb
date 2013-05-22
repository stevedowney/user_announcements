class Admin::AnnouncementsController <  Admin::BaseController
  before_filter :find_announcement, :only => [:edit, :update, :destroy]

  def index
    @announcements = Announcement.all#AnnouncementFinder.ordered
  end
  
  def new
    @announcement = Announcement.new_with_defaults
  end
  
  def edit
  end
  
  def create
    @announcement = Announcement.new(params.fetch(:announcement))
    if @announcement.save
      redirect_to admin_announcements_path, :flash => { success: 'Announcement created'}
    else
      render "new"
    end
  end
  
  def update
    if @announcement.update_attributes(params.fetch(:announcement))
      redirect_to admin_announcements_path, :flash => { success: 'Announcement updated' }
    else
      render "edit"
    end
  end
  
  def destroy
    @announcement.destroy
    redirect_to admin_announcements_path, :flash => { success: 'Announcement deleted' }
  end

protected

  def find_announcement
    @announcement = Announcement.find(params.fetch(:id))
  end
end
