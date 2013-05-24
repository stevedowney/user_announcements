require 'spec_helper'

describe Announcement do
  
  describe 'validations' do
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:starts_at) }
    it { should validate_presence_of(:ends_at) }
  end
  
  describe '#current?' do
    it "current" do
      saved_current_announcement.should be_current
    end
    
    it "not current" do
      saved_past_announcement.should_not be_current
      saved_future_announcement.should_not be_current
    end
  end
  
  describe '#status' do
    it "statuses" do
      saved_current_announcement.status.should == Announcement::CURRENT
      saved_past_announcement.status.should == Announcement::PAST
      saved_future_announcement.status.should == Announcement::FUTURE
      saved_inactive_announcement.status.should == Announcement::INACTIVE
    end
  end
  
  describe '#status_order' do
    it "based on status" do
      saved_future_announcement.status_order.should == 1
    end
  end
  
  describe 'class methods' do

    describe '.new_with_defaults' do
      let(:ann) { Announcement.new_with_defaults }
      
      it "be active" do
        ann.should be_active
      end
      
      it "starts_at defaults to now" do
        ann.starts_at.should be_within(1).of(DateTime.now)
      end
      
      it "ends one week from now at end of day" do
        ann.ends_at.should be_within(1).of(1.week.from_now.end_of_day)
      end
    end
    
    describe '.active' do
      it "only gets active" do
        current_announcement = saved_current_announcement
        saved_inactive_announcement
        Announcement.active.should == [current_announcement]
      end
    end
  end
  
end
