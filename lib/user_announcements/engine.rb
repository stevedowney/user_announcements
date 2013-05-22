module UserAnnouncements
  class Engine < ::Rails::Engine
    config.generators.integration_tool :rspec
    config.generators.test_framework :rspec
  end
  
  def self.config(&block)
    yield Engine.config if block
    Engine.config
  end
end
