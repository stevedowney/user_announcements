require 'rails/generators/active_record/migration'

module UserAnnouncements
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      extend ActiveRecord::Generators::Migration
      source_root File.join(File.dirname(__FILE__), "templates")

      desc <<DESC
Description:
    Copies stylesheet    to 'app/assets/stylesheets/user_announcements.css'
    Copies configuration to 'config/initializers/user_announcements.rb'
    Copies db migration  to 'db/migrate/<timestamp>/create_user_announcement_tables.rb'
    
DESC
  
      def install
        copy_file "template.css", 'app/assets/stylesheets/user_announcements.css'
        copy_file "initializer.rb", 'config/initializers/user_announcements.rb'
        migration_template "migration.rb", "db/migrate/create_user_announcement_tables.rb"
      end

    end
  end
end

