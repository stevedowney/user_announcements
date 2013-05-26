# note: all options accept lambdas

UserAnnouncements.config do |config|

  # using Bootstrap
  config.bootstrap = true
  # config.bootstrap = false

  # Announcement defaults
  config.default_active = true
  config.default_starts_at = lambda { Time.now.in_time_zone }
  config.default_ends_at = lambda { 1.week.from_now.in_time_zone.end_of_day }
  config.default_roles = ['']
  config.default_style = ''

  # Roles
  config.roles = []
  # config.roles = ['', 'admin']
  # config.roles = [ ['Public', ''], ['Administrator', 'admin'] ]
  # config.roles = lambda { MyRoleClass.map { |role| [role.name, role.id] } }  
  
  # Bootstrap styles
  config.styles = [['Yellow', ''], ['Red', 'alert-error'], ['Green', 'alert-success'], ['Blue', 'alert-info']]
  # non-Bootstrap styles
  # config.styles = [['Yellow', 'yellow'], ['Red', 'red'], ['Green', 'green'], ['Blue', 'blue']]
  
end