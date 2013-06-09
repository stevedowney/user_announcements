$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "user_announcements/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "user_announcements"
  s.version     = UserAnnouncements::VERSION
  s.authors     = ["Steve Downey"]
  s.email       = ["steve.downtown@gmail.com"]
  s.homepage    = "https://github.com/stevedowney/user_announcements"
  s.summary     = "Manage and display site-wide announcements by user, scoped by user role."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "CHANGELOG.md", "Rakefile", "README.md"]

  s.platform       = RUBY_PLATFORM =~ /java/ ? 'jruby' : 'ruby'
  
  s.add_dependency "rails"
  s.add_dependency "jquery-rails"
  
  s.add_development_dependency 'sass-rails', '~> 3.2'
  s.add_development_dependency 'bootstrap-sass', '~> 2.3.1.0'
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'launchy'
  s.add_development_dependency "generator_spec"
  s.add_development_dependency "capybara"
  s.add_development_dependency "capybara-webkit"
  
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'shoulda-matchers'  
  s.add_development_dependency 'database_cleaner'
  
  if s.platform == 'java'
    s.add_development_dependency 'activerecord-jdbcsqlite3-adapter'
  else
    s.add_development_dependency "sqlite3"
  end

  if ENV['ENGINE_DEVELOPER'] == 'true'
    s.add_development_dependency 'better_errors'
    s.add_development_dependency 'binding_of_caller'
    s.add_development_dependency "redcarpet"
    s.add_development_dependency "yard"
    s.add_development_dependency 'quiet_assets'
    s.add_development_dependency 'thin'
  end
end
