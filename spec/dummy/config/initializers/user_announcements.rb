UserAnnouncements.config do |config|
  
  config.bootstrap = true
  config.styles = [['Yellow', ''], ['Red', 'alert-error'], ['Green', 'alert-success'], ['Blue', 'alert-info']]

  config.default_roles = ['admin']
  config.default_style = 'alert-info'
  
  config.roles = [['Public', ''], ['Admin', 'admin']]
  # config.bootstrap = false
  # config.styles = %w(yellow red green blue)
  
  # config.default_active = true
  # config.default_starts_at = lambda { Time.now.in_time_zone }
  # config.default_ends_at = lambda { 1.week.from_now.in_time_zone.end_of_day }
  
end