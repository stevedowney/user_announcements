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
  
end
