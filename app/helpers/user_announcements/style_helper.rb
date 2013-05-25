module UserAnnouncements::StyleHelper
  
  # Style dropdown for admin detail form
  def ua_style_html(f)
    return unless _ua_styles.present?

    f.label(:style) +
    ua_br + 
    f.select(:style, _ua_styles)
  end
  
  private
  
  def _ua_styles
    @_ua_styles ||= UserAnnouncements[:styles].map do |style|
      (style.is_a?(Array) ? style : [style, style]).map(&:to_s)
    end
  end
  
end