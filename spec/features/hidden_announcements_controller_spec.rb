require 'spec_helper'

describe HiddenAnnouncementsController, :type => :feature do
  before :each do
    login user
  end

  let(:user) { saved_user }
  
  it "index" do
    announcement = saved_announcement(message: 'my message', starts_at: 1.day.ago, ends_at: 1.day.from_now)
    HiddenAnnouncement.create_for(user.id, announcement.id)
    visit hidden_announcements_path
    page.should have_selector('h1', text: 'Announcements')
    page.should have_content('my message')
  end
  
  describe 'create', js: true do
    it "bootstrap" do
      # announcement = current_announcement
      # visit '/'
      # page.should have_content('current')
      # save_and_open_page
      # link = find("#hide_announcement_#{announcement.id}")
      # # find.click
    end
  
    it "non-bootstrap" do
      # announcement = current_announcement
      # visit '/?bootstrap=false'
      # page.should have_content('current')
      # save_and_open_page
      # click_on 'hide announcement'
      # link = find("#hide_announcement_#{announcement.id}")
      # # find.click
    end
  end
  
  describe 'destroy' do
    it "destroys" do
      announcement = current_announcement
      HiddenAnnouncement.create_for(user.id, announcement.id)
      visit '/announcements'
      page.should have_content('current')
      page.should have_link('hide')
      click_on 'hide'
      page.should_not have_link('hide')
      HiddenAnnouncement.count.should == 0
    end
  end
end
