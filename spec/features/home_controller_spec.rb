require 'spec_helper'

describe HomeController, :type => :feature do
  before :each do
    login user
  end

  let(:user) { saved_user }
  
  it "see current" do
    saved_current_announcement
    saved_past_announcement
    saved_future_announcement
    saved_inactive_announcement
    
    visit '/'
    page.should have_content('current')
    page.should_not have_content('past')
    page.should_not have_content('future')
    page.should_not have_content('inactive')
  end
  
  it "bootstrap" do
    saved_current_announcement
    visit '/?bootstrap=true'
    page.should have_selector('div.announcement.alert', text: 'current')
  end

  it "non-bootstrap" do
    saved_current_announcement
    visit '/?bootstrap=false'
    page.should have_selector('div.announcement.non-bootstrap', text: 'current')
  end
end