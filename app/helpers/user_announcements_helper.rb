module UserAnnouncementsHelper
  
  # Helper method for displaying messages for +current_user+.
  def user_announcements(options={})
    return if controller.controller_name == 'user_announcements'
    
    announcements_rows = AnnouncementFinder.current_for_user(current_user)
    divs = announcements_rows.map do |announcement|
      announcement_div(announcement)
    end
    
    safe_join(divs, "\n")
  end
  
  def announcement_div(announcement)
    # <div class="alert">
    #   <button type="button" class="close" data-dismiss="alert">&times;</button>
    #   <strong>Warning!</strong> Best check yo self, you're not looking too good.
    # </div>
    
    div_for announcement, class: 'alert', style: 'width:40em' do
      link_to(hide_user_announcement_path(announcement), remote: true) do
        content_tag(:button, raw('&times;'), type: 'button', class: 'close', data: {dismissx: 'alert'})
      end + 
      announcement.message.html_safe
    end
    # div_for(announcement) do
    #   announcement.message.html_safe +
    #   link_to("hide announcement", 'hide_announcement_path(announcement)', remote: true)
    # end
  end
  
  def unhide_announcement_link(announcement)
    if @hidden_announcement_ids.include?(announcement.id)
      content_tag(:div) do
        link_to('Unhide', unhide_user_announcement_path(announcement), method: :post)
      end
    end
  end
  
  def boolean_display(boolean)
    ( boolean ? '&#10004;' : '&nbsp;' ).html_safe
  end
  
  def active_model_errors(model)
    return unless model.errors.present?

    content_tag(:div, class: ['alert', 'alert-error']) do
      content_tag(:h4, "Correct the following errors:") +
      content_tag(:ul) do
        safe_join(model.errors.full_messages.map { |msg| content_tag(:li, msg) }, "\n")
      end
    end
  end
  
  def ua_datetime_p(f, method)
    content_tag(:p, class: 'datetime-select') do
      f.label(method) + 
      f.datetime_select(method)
    end
  end
  
end