require 'rails/generators/active_record/migration'

class UserAnnouncementsGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  extend ActiveRecord::Generators::Migration

  desc "Put the code"
  source_root File.join(File.dirname(__FILE__), "templates")

  def install
    # copy_javascript if needs_js_copied?
    migration_template "create_user_announcement_tables.rb", "db/migrate/create_user_announcement_tables.rb"
  end

  private

  def copy_javascript
    copy_file File.join(javascript_path, 'announcements.js'), js_destination
  end

  def javascript_path
    File.join(%w(.. .. .. .. app assets javascripts))
  end

  def needs_js_copied?
    ::Rails.version < '3.1' || !::Rails.application.config.assets.enabled
  end

  def js_destination
    'public/javascripts/announcements.js'
  end
end