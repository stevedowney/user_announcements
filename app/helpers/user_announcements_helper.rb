module UserAnnouncementsHelper
  include UserAnnouncements::RolesHelper
  include UserAnnouncements::MiscHelper
  include UserAnnouncements::StyleHelper
  include UserAnnouncements::ShowAnnouncements
  
  def hide_announcement_link_args(announcement)
    url = hidden_announcements_path(announcement_id: announcement)
    options = {
      method: :post,
      remote: true,
      id: "hide_#{dom_id(announcement)}"
    }
    
    [url, options]
  end
  
  def unhide_announcement_link(announcement)
    if @hidden_announcement_ids.include?(announcement.id)
      content_tag(:div) do
        link_to('Unhide', hidden_announcement_path(announcement, announcement_id: announcement), method: :delete)
      end
    end
  end
  
  def ua_table_attrs
    if bootstrap?
      {class: "ua-table bootstrap table table-striped table-bordered table-hover"}
    else
      {class: 'ua-table non-bootstrap'}
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
      ua_br +      
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