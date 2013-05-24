require 'spec_helper'

describe HiddenAnnouncementsController, :type => :feature do
  before :each do
    login user
  end

  let(:user) { saved_user }
  
  it "requires current_user to be defined" do
    ENV['ENSURE_CURRENT_USER_TEST'] = 'true'
    begin
      expect { visit hidden_announcements_path }
        .to raise_error(ApplicationController::CurrentUserMethodNotDefinedError)
    ensure
      ENV['ENSURE_CURRENT_USER_TEST'] = nil
    end
  end
  
  it "index" do
    announcement = saved_announcement(message: 'my message', starts_at: 1.day.ago, ends_at: 1.day.from_now)
    HiddenAnnouncement.create_for(user.id, announcement.id)
    visit hidden_announcements_path
    page.should have_selector('h1', text: 'Announcements')
    page.should have_content('my message')
  end
  
  # TODO: specs that test JS
  describe 'create' do
    it "bootstrap" do
      announcement = current_announcement
      visit root_url(bootstrap: 'true')
      page.should have_content('current')
      click_on "hide_announcement_#{announcement.id}"
      page.should_not have_content('current')
    end
  
    it "non-bootstrap" do
      announcement = current_announcement
      visit root_url(bootstrap: 'false')
      page.should have_content('current')
      click_on "hide_announcement_#{announcement.id}"
      page.should_not have_content('current')
    end
  end
  
  # TODO: specs that test JS
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
