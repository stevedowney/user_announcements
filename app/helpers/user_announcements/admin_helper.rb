module UserAnnouncements::AdminHelper
  
  def _ua_active_model_errors(model)
    return unless model.errors.present?

    content_tag(:div, class: ['alert', 'alert-error']) do
      content_tag(:h4, "Correct the following errors:") +
      content_tag(:ul) do
        safe_join(model.errors.full_messages.map { |msg| content_tag(:li, msg) }, "\n")
      end
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
  
  def ua_datetime_p(f, method)
    content_tag(:p, class: 'datetime-select') do
      f.label(method) + 
      ua_br +      
      f.datetime_select(method)
    end
  end
  
  private

  def ua_table_attrs
    if ua_bootstrap?
      {class: "ua-table bootstrap table table-striped table-bordered table-hover"}
    else
      {class: 'ua-table non-bootstrap'}
    end
  end
  
  
end