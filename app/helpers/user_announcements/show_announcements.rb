module UserAnnouncements::ShowAnnouncements
  
  # Helper method for displaying messages for +current_user+.
  def user_announcements(options={})
    return if controller.controller_name == 'hidden_announcements'
    
    announcements_rows = AnnouncementFinder.current_for_user(current_user)
    divs = announcements_rows.map do |announcement|
      announcement_div(announcement)
    end
    
    safe_join(divs, "\n")
  end
  
  
end