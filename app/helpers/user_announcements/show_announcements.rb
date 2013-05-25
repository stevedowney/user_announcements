module UserAnnouncements::ShowAnnouncements
  
  # Helper method for displaying messages for +current_user+.
  def user_announcements(options={})
    return if controller.controller_name == 'hidden_announcements'
    
    announcements_rows = AnnouncementFinder.for_display(current_user)
    divs = announcements_rows.map do |announcement|
      announcement_div(announcement)
    end
    
    safe_join(divs, "\n")
  end
  
  private
  
  def announcement_div(ann)
    if bootstrap?
      announcement_div_bootstrap(ann)
    else
      announcement_div_non_bootstrap(ann)
    end
  end
  
  def announcement_div_bootstrap(ann)
    div_for ann, class: _ua_announcement_classes(ann.style), style: 'width:40em' do
      link_to(*hide_announcement_link_args(ann)) do
        content_tag(:button, raw('&times;'), type: 'button', class: 'close')
      end + 
      ann.message.html_safe
    end
  end
  
  def announcement_div_non_bootstrap(ann)
    div_for(ann, class: _ua_announcement_classes(ann.style)) do
      ann.message.html_safe +
      link_to("hide announcement", *hide_announcement_link_args(ann))
    end
  end
  
  def _ua_announcement_classes(style)
    bootstrap_or_non = bootstrap? ? 'bootstrap alert' : 'non-bootstrap'
    [bootstrap_or_non, style.presence].compact.join(' ')
  end
  
end