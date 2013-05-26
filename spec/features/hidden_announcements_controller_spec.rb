require 'spec_helper'

describe HiddenAnnouncementsController, :type => :feature do
  before :each do
    login user
  end

  let(:user) { saved_user }
  
  it "index" do
    announcement = saved_current_announcement
    HiddenAnnouncement.create_for(user.id, announcement.id)
    visit hidden_announcements_path
    page.should have_selector('h1', text: 'Announcements')
    page.should have_content('current')
  end
  
  # TODO: specs that test JS
  describe 'create' do
    it "bootstrap" do
      announcement = saved_current_announcement
      visit root_url(bootstrap: 'true')
      page.should have_content('current')
      click_on "hide_announcement_#{announcement.id}"
      page.should_not have_content('current')
    end
  
    it "non-bootstrap" do
      announcement = saved_current_announcement
      visit root_url(bootstrap: 'false')
      page.should have_content('current')
      click_on "hide_announcement_#{announcement.id}"
      page.should_not have_content('current')
    end
  end
  
  # TODO: specs that test JS
  describe 'destroy' do
    it "destroys" do
      announcement = saved_current_announcement
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
