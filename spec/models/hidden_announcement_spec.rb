require 'spec_helper'

describe HiddenAnnouncement do
  let(:user) { saved_user }
  let(:announcement) { saved_current_announcement }
  let(:user_announcement) { HiddenAnnouncement.first! }
    
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:announcement_id) }
  end
  
  describe '.create_for' do
    before(:each) do
      HiddenAnnouncement.create_for(user.id, announcement.id)
    end

    it 'creates' do
      user_announcement.user_id.should == user.id
      user_announcement.announcement_id.should == announcement.id
    end
    
    it "doesn't create duplicates" do
      HiddenAnnouncement.create_for(user.id, announcement.id)
      HiddenAnnouncement.count.should == 1
    end
  end
  
  describe '.hidden_announcement_ids_for' do
    before(:each) do
      HiddenAnnouncement.create_for(user.id, announcement.id)
    end

    it "returns hidden ids" do
      HiddenAnnouncement.hidden_announcement_ids_for(user.id).should == [announcement.id]
    end
    
  end
end