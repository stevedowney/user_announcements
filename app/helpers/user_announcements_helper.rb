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
    if bootstrap?
      announcement_div_bootstrap(announcement)
    else
      announcement_div_non_bootstrap(announcement)
    end
  end
  
  def announcement_div_bootstrap(announcement)
    div_for announcement, class: 'alert', style: 'width:40em' do
      link_to(hide_user_announcement_path(announcement), remote: true) do
        content_tag(:button, raw('&times;'), type: 'button', class: 'close')
      end + 
      announcement.message.html_safe
    end
  end
  
  def announcement_div_non_bootstrap(announcement)
    div_for(announcement, class: 'non-bootstrap') do
      announcement.message.html_safe +
      link_to("hide announcement", hide_user_announcement_path(announcement), remote: true)
    end
  end
  
  def unhide_announcement_link(announcement)
    if @hidden_announcement_ids.include?(announcement.id)
      content_tag(:div) do
        link_to('Unhide', unhide_user_announcement_path(announcement), method: :post)
      end
    end
  end
  
  def ua_table_attrs
    if bootstrap?
      {class: "table table-striped table-bordered table-condensed table-hover"}
    else
      {class: 'ua-table'}
    end
  end
  
  def ua_table_tag(options={})
    content_tag(:table, options.merge(ua_table_attrs)) do
      yield
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
  
  def bootstrap?
    if params.has_key?(:bootstrap)
      params[:bootstrap] == 'true'
    else
      UserAnnouncements.config.bootstrap
    end
  end
end