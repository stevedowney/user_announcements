puts '*** load UserAnnouncements'
module UserAnnouncements
  
  class Engine < ::Rails::Engine
    config.generators.integration_tool :rspec
    config.generators.test_framework :rspec
    
    config.bootstrap = true
  
    config.default_active = true
    config.default_starts_at = lambda { Time.now.in_time_zone }
    config.default_ends_at = lambda { 1.week.from_now.in_time_zone.end_of_day }
    config.default_roles = ['']
    config.default_style = ''
    
    config.roles = []
    config.styles = [['Yellow', ''], ['Red', 'alert-error'], ['Green', 'alert-success'], ['Blue', 'alert-info']]
    config.types = []
    
    initializer 'user_announcements.action_controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        include UserAnnouncements::ControllerMethods
      end
    end
    
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
