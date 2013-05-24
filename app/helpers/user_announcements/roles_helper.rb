module UserAnnouncements::RolesHelper

  # Roles checkboxes for admin detail form
  def ua_roles_html(f)
    return unless _ua_roles.present?

    f.label(:roles) + _ua_roles_checkboxes(_ua_roles)
  end

  # Roles display on index page
  def ua_roles_display(announcement)
    announcement.roles.map { |role_id| _ua_role_id_to_name(role_id) }.join(", ")
  end
  
  private
  
  def _ua_roles_checkboxes(roles)
    safe_join( roles.map { |role| _ua_role_checkbox(role) } )
  end

  def _ua_role_checkbox(role)
    role_id, role_name = role.is_a?(Array) ? role : [role, role]
    id = "role_#{role_id}"
    checked = @announcement.roles.include?(role_id)

    check_box_tag('announcement[roles][]', role_id, checked, id: id) + ' ' +
      label_tag(id, role_name, style: "display: inline; margin-right: 1em")
  end

  def _ua_role_id_to_name(role_id)
    _ua_roles.detect { |id, name| id == role_id  }.try(:last)
  end
  
  def _ua_roles
    @_ua_roles ||= UserAnnouncements[:roles].map do |role|
      (role.is_a?(Array) ? role : [role, role]).map(&:to_s)
    end
  end
end