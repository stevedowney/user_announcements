require 'rails/generators/active_record/migration'

module UserAnnouncements
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      extend ActiveRecord::Generators::Migration
      source_root File.join(File.dirname(__FILE__), "templates")

      desc <<DESC
Description:
    Copies configuration file to 'config/initializers/user_announcements.rb'
    Copies db migration  file to 'db/migrate/<timestamp>/create_user_announcement_tables.rb'
    
DESC
  
      def install
        copy_file "initializer.rb", 'config/initializers/user_announcements.rb'
        migration_template "migration.rb", "db/migrate/create_user_announcement_tables.rb"
      end

    end
  end
end

