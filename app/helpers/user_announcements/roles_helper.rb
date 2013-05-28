module UserAnnouncements::RolesHelper
  Role = Struct.new(:name, :id) 
  
  # Roles checkboxes for admin detail form
  def ua_roles_html(f)
    return unless _ua_roles.present?

    f.label(:roles) +
    ua_br + 
    _ua_roles_checkboxes(_ua_roles)
  end

  # Roles display on index page
  def ua_roles_display(announcement)
    role_names = announcement.roles.map { |role_id| _ua_role_id_to_name(role_id) }

    safe_join(role_names, '<br />'.html_safe)
  end
  
  private
  
  def _ua_roles_checkboxes(roles)
    safe_join( roles.map { |role| _ua_role_checkbox(role) }, '<br>'.html_safe )
  end

  def _ua_role_checkbox(role)
    id = "role_#{role.id}"
    checked = @announcement.roles.include?(role.id)

    check_box_tag('announcement[roles][]', role.id, checked, id: id) + ' ' +
      label_tag(id, role.name, style: "display: inline; margin-right: 1em")
  end

  def _ua_role_id_to_name(role_id)
    _ua_roles.detect { |role| role.id == role_id  }.try(:name)
  end
  
  def _ua_roles
    @_ua_roles ||= Array(UserAnnouncements[:roles]).map do |role|
      name_id = (role.is_a?(Array) ? role : [role, role]).map(&:to_s)
      Role.new(name_id.first, name_id.last)
    end
  end
end