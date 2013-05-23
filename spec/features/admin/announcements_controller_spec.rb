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
  
  describe 'create' do
    before(:each) do
      visit admin_announcements_path
      click_on 'New Announcement'
    end

    it "failure" do
      click_on "Create Announcement"
      page.should have_content("can't be blank")
    end
    
    it "success" do
      fill_in "Message", with: 'my new message'
      click_on "Create Announcement"
      page.should have_selector('h1', text: 'Administer Announcements')
      page.should have_content('my new message')
    end
  end
  
  describe 'update' do
    before(:each) do
      saved_announcement
      visit admin_announcements_path
      click_on 'edit'
    end

    it "failure" do
      fill_in "Message", with: ''
      click_on "Update Announcement"
      page.should have_content("can't be blank")
    end
    
    it "success" do
      fill_in "Message", with: 'my updated message'
      click_on "Update Announcement"
      page.should have_selector('h1', text: 'Administer Announcements')
      page.should have_content('my updated message')
    end
  end
end
