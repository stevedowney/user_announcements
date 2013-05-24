module UserAnnouncements
  
  class Engine < ::Rails::Engine
    config.generators.integration_tool :rspec
    config.generators.test_framework :rspec
    
    config.bootstrap = true
  
    config.default_active = true
    config.default_starts_at = lambda { Time.now.in_time_zone }
    config.default_ends_at = lambda { 1.week.from_now.in_time_zone.end_of_day }
    
    config.roles = [['', 'Public'], ['admin', 'Admin']]
    config.types = []
    config.styles = %w(error succes info)
    
  end
  
  def self.config(&block)
    yield Engine.config if block
    Engine.config
  end
  
  def self.[](key)
    setting = config.send(key)
    
    if setting.is_a?(Proc)
      setting.call
    else
      setting
    end
  end
end
