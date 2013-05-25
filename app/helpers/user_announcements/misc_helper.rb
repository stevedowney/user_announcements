module UserAnnouncements::MiscHelper
  
  def ua_datetime_display(datetime)
    if datetime.present?
      datetime.to_s(:short)
    else
      nil
    end
  end
  
  # Return a <br> tag if not bootstrap?
  def ua_br
    "<br />".html_safe unless bootstrap?
  end
end