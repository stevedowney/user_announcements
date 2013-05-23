require 'spec_helper'

describe Admin::AnnouncementsController, :type => :feature do
  before :each do
    create_and_login_user
  end

  it "index" do
    announcement = saved_announcement(message: 'my message')
    visit admin_announcements_path
    page.should have_selector('h1', text: 'Administer Announcements')
    page.should have_content('my message')
  end
  
end
