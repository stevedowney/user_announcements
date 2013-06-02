require "generator_spec/test_case"

require UserAnnouncements::Engine.root.join('lib/generators/user_announcements/install_generator')

describe UserAnnouncements::Generators::InstallGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../tmp", __FILE__)
  before { prepare_destination }
  after  { rm_rf(destination_root) }
  
  it "defaults" do
    run_generator
    
    destination_root.should have_structure {
      directory 'app/assets' do
        directory 'javascripts/user_announcements' do
          file 'bootstrap-datetimepicker.min.js'
        end
        directory 'stylesheets/user_announcements' do
          file 'bootstrap-datetimepicker.min.css'
          file 'user_announcements.css.scss'
        end 
      end
      
      directory "config/initializers" do
        file "user_announcements.rb" do
          contains "using_bootstrap = true"
          contains "config.bootstrap_datetime_picker = true"
        end
      end
      
      directory 'db/migrate' do
        migration 'create_user_announcement_tables.rb' do
          contains 'create_table :announcements'
        end
      end
    }
  end
  
  it "--no-bootstrap" do
    run_generator %w(--no-bootstrap)
    
    destination_root.should have_structure {
      directory 'app/assets' do
        directory 'javascripts/user_announcements' do
          no_file 'bootstrap-datetimepicker.min.js'
        end
        directory 'stylesheets/user_announcements' do
          no_file 'bootstrap-datetimepicker.min.css'
          file 'user_announcements.css.scss'
        end 
      end
      
      directory "config/initializers" do
        file "user_announcements.rb" do
          contains "using_bootstrap = false"
          contains "config.bootstrap_datetime_picker = true"
        end
      end
      
      directory 'db/migrate' do
        migration 'create_user_announcement_tables.rb' do
          contains 'create_table :announcements'
        end
      end
    }
  end
  
  it "--no-bootstrap_dtp" do
    run_generator %w(--no-bootstrap-dtp)
    
    destination_root.should have_structure {
      directory 'app/assets' do
        directory 'javascripts/user_announcements' do
          no_file 'bootstrap-datetimepicker.min.js'
        end
        directory 'stylesheets/user_announcements' do
          no_file 'bootstrap-datetimepicker.min.css'
          file 'user_announcements.css.scss'
        end 
      end
      
      directory "config/initializers" do
        file "user_announcements.rb" do
          contains "using_bootstrap = true"
          contains "config.bootstrap_datetime_picker = false"
        end
      end
      
      directory 'db/migrate' do
        migration 'create_user_announcement_tables.rb' do
          contains 'create_table :announcements'
        end
      end
    }
  end
  
  it "--readme" do
    run_generator %w(--readme)
    
    assert_no_directory 'app'
    assert_no_directory 'config'
    assert_no_directory 'db'
  end

end