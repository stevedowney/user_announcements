require 'spec_helper'

describe HomeController, :type => :feature do
  before :each do
    login user
  end

  let(:user) { saved_user }
  
  it "see current" do
    current_announcement
    past_announcement
    future_announcement
    inactive_announcement
    
    puts current_announcement.inspect
    visit '/'
    page.should have_content('current')
    page.should_not have_content('past')
    page.should_not have_content('future')
    page.should_not have_content('inactive')
  end
  
  it "bootstrap" do
    current_announcement
    visit '/?bootstrap=true'
    page.should have_selector('div.announcement.alert', text: 'current')
  end

  it "non-bootstrap" do
    current = saved_announcement(message: 'current', starts_at: 1.day.ago, ends_at: 1.day.from_now)
    visit '/?bootstrap=false'
    page.should have_selector('div.announcement.non-bootstrap', text: 'current')
  end
end