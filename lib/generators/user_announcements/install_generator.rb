require 'rails/generators/active_record/migration'

module UserAnnouncements
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      extend ActiveRecord::Generators::Migration
      source_root File.join(File.dirname(__FILE__), "templates")

      desc %(Copy user_announcements files.
* assumes Bootstrap by default
* if you are not using Bootstrap or have your own copy of the Bootstrap datetimepicker assets, see:
  * --no_bootstrap
  * --no_bootstrap_dtp

)
 
      class_option :no_bootstrap, aliases: '-n', type: :boolean, desc: 'Do not configure for Bootstrap; do not copy Bootstrap datetimepicker assets'
      class_option :no_bootstrap_dtp, aliases: '-d', type: :boolean, desc: 'Do not copy Bootstrap datetimepicker assets'
      class_option :readme, aliases: '-r', type: :boolean, desc: 'Display README and exit'
  
      def readme_only
        puts "behavior: #{behavior}"
        # if options.readme?
        #   readme_to_console
        #   exit
        # end
      end
      
      def copy_bootstrap_datetime_picker_assets
        return if options.readme?
        unless options.no_bootstrap? || options.no_bootstrap_dtp?
          copy_file 'app/assets/javascripts/user_announcements/bootstrap-datetimepicker.min.js'
          copy_file 'app/assets/stylesheets/user_announcements/bootstrap-datetimepicker.min.css'
        end
      end
      
      def install_base_files
        return if options.readme?
        copy_file 'app/assets/stylesheets/user_announcements/user_announcements.css.scss'
        template  'config/initializers/user_announcements.rb'
        migration_template "migration.rb", "db/migrate/create_user_announcement_tables.rb"
      end

      def show_readme
        if behavior == :invoke
          readme_to_console
        end
      end
      
      private
      
      def readme_to_console
        readme "README"
      end
      
    end
  end
end

