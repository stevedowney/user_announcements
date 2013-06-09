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
  
  def ua_boolean_display(boolean)
    ( boolean ? '&#10004;' : '&nbsp;' ).html_safe
  end
  
  def ua_datetime_p(f, method)
    if ua_bootstrap_datetime_picker?
      ua_datetime_p_bootstrap(f, method)
    else
      ua_datetime_p_non_bootstrap(f, method)
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
  
  def ua_datetime_p_bootstrap(f, method)
    value = f.object.send(method).try(:strftime, "%Y-%m-%d %H:%M")
    %(<p class="input-append date ua-datetimepicker" style: "display:block !important">
      #{f.label(method)}
      #{f.text_field(method, value: value, data: {format: "yyyy-MM-dd hh:mm"})}
      <span class="add-on">
        <i data-time-icon="icon-time" data-date-icon="icon-calendar">
        </i>
      </span>
    </p>).html_safe
  end

  def ua_datetime_p_non_bootstrap(f, method)
    content_tag(:p, class: 'datetime-select') do
      f.label(method) + 
      ua_br +      
      f.datetime_select(method)
    end
  end
  
  
end