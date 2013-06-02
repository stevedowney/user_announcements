require 'spec_helper'

describe Admin::AnnouncementsController, :type => :feature do
  before :each do
    create_and_login_user
  end

  it "index" do
    saved_current_announcement
    visit admin_announcements_path
    page.should have_selector('h1', text: 'Administer Announcements')
    page.should have_content('current')
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
      # check 'Public'
      click_on "Create Announcement"
      page.should have_selector('h1', text: 'Administer Announcements')
      page.should have_content('my new message')
    end
  end
  
  describe 'update' do
    before(:each) do
      saved_current_announcement
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
  
  describe 'delete' do
    before(:each) do
      saved_current_announcement
      visit admin_announcements_path
      page.should have_content('current')
      click_on 'delete'
    end

    it "delete" do
      page.should_not have_content('current')
    end
    
  end
  
  describe 'non-bootstrap' do
    describe 'create' do
      before(:each) do
        visit admin_announcements_path(bootstrap: false)
        click_on 'New Announcement'
      end

      it "failure" do
        click_on "Create Announcement"
        page.should have_content("can't be blank")
      end

      it "success" do
        fill_in "Message", with: 'my new message'
        # check 'Public'
        click_on "Create Announcement"
        page.should have_selector('h1', text: 'Administer Announcements')
        page.should have_content('my new message')
      end
    end
  end
  
  describe 'with roles' do
    describe 'create' do
      before(:each) do
        @_roles = UserAnnouncements[:roles]
        UserAnnouncements.config.roles = ['','Admin']
        visit admin_announcements_path(bootstrap: false)
        click_on 'New Announcement'
      end
      after { UserAnnouncements.config.roles = @_roles }

      it "failure" do
        click_on "Create Announcement"
        page.should have_content("can't be blank")
      end

      it "success" do
        fill_in "Message", with: 'my new message'
        # check 'Public'
        click_on "Create Announcement"
        page.should have_selector('h1', text: 'Administer Announcements')
        page.should have_content('my new message')
      end
    end
  end
  
  describe 'table attributes' do
    before(:each) do
      saved_current_announcement
    end
    
    it "bootstrap" do
      visit admin_announcements_path(bootstrap: 'true')
      page.should have_selector('table.ua-table.bootstrap')
    end

    it "non-bootstrap" do
      visit admin_announcements_path(bootstrap: 'false')
      page.should have_selector('table.ua-table.non-bootstrap')
    end
  end
  
end
