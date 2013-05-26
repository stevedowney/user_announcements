# note: all options accept lambdas

UserAnnouncements.config do |config|

  # Bootstrap
  config.bootstrap = true
  config.styles = [['Yellow', ''], ['Red', 'alert-error'], ['Green', 'alert-success'], ['Blue', 'alert-info']]

  # non-Bootstrap
  # config.bootstrap = false
  # config.styles = [['Yellow', 'yellow'], ['Red', 'red'], ['Green', 'green'], ['Blue', 'blue']]

  # Announcement defaults
  config.default_active = true
  config.default_starts_at = lambda { Time.now.in_time_zone }
  config.default_ends_at = lambda { 1.week.from_now.in_time_zone.end_of_day }
  config.default_style = ''
  # config.default_roles = ['admin']

  # Roles
  # config.roles = []
  # config.roles = ['', 'admin']
  # config.roles = [ ['Public', ''], ['Administrator', 'admin'] ]
  # config.roles = lambda { MyRoleClass.map { |role| [role.name, role.id] } }  
  
end