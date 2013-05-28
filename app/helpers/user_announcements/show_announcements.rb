module UserAnnouncements::ShowAnnouncements
  
  # Helper method for displaying messages for +current_user+.
  def user_announcements(options={})
    return if controller.controller_name == 'hidden_announcements'
    
    announcements_rows = AnnouncementFinder.for_display(current_user)
    divs = announcements_rows.map do |announcement|
      _ua_announcement_div(announcement)
    end
    
    safe_join(divs, "\n")
  end
  
  private
  
  def _ua_announcement_div(ann)
    if ua_bootstrap?
      _ua_announcement_div_bootstrap(ann)
    else
      _ua_announcement_div_non_bootstrap(ann)
    end
  end
  
  def _ua_announcement_div_bootstrap(ann)
    div_for ann, class: _ua_announcement_classes(ann.style) do
      link_to(*_ua_hide_announcement_link_args(ann)) do
        content_tag(:button, raw('&times;'), type: 'button', class: 'close')
      end + 
      ann.message.html_safe
    end
  end
  
  def _ua_announcement_div_non_bootstrap(ann)
    div_for(ann, class: _ua_announcement_classes(ann.style)) do
      ann.message.html_safe +
      link_to("hide announcement", *_ua_hide_announcement_link_args(ann))
    end
  end
  
  def _ua_hide_announcement_link_args(announcement)
    url = hidden_announcements_path(announcement_id: announcement)
    options = {
      method: :post,
      remote: true,
      id: "hide_#{dom_id(announcement)}"
    }
    
    [url, options]
  end
  
  def _ua_unhide_announcement_link(announcement)
    if @hidden_announcement_ids.include?(announcement.id)
      content_tag(:div) do
        link_to('Unhide', hidden_announcement_path(announcement, announcement_id: announcement), method: :delete)
      end
    end
  end
  
  
  def _ua_announcement_classes(style)
    bootstrap_or_non = ua_bootstrap? ? 'bootstrap alert' : 'non-bootstrap'
    [bootstrap_or_non, style.presence].compact.join(' ')
  end
  
end