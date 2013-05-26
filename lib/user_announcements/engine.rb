module UserAnnouncements
  
  class Engine < ::Rails::Engine

    config.generators.integration_tool :rspec
    config.generators.test_framework :rspec
    
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
    
  rescue NameError
    Rails.logger.debug "[UserAnnouncements] Tried to access unknown UserAnnouncements.config key: #{key.inspect}"
    nil
  end
end
