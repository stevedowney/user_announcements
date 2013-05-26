require 'spec_helper'

describe Announcement do
  
  describe 'validations' do
    it { should validate_presence_of(:message) }
  end
  
  describe 'serialization' do
    its(:roles) { should be_instance_of(Array) }
    its(:types) { should be_instance_of(Array) }
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
  
  describe '#starts_at_for_user' do
    it "starts_at if present" do
      ann = Announcement.new(starts_at: 1.day.ago)
      ann.starts_at_for_user.should == ann.starts_at
    end
    
    it "created_at if no starts_at" do
      ann = Announcement.new({created_at: 1.day.ago}, without_protection: true)
      ann.starts_at_for_user.should == ann.created_at
    end
  end
  
  describe 'class methods' do

    describe '.new_with_defaults' do
      let(:ann) { Announcement.new_with_defaults }
      
      it "be active" do
        ann.active.should == UserAnnouncements[:default_active]
      end
      
      it "starts_at defaults to now" do
        ann.starts_at.should be_within(1).of(UserAnnouncements[:default_starts_at])
      end
      
      it "ends one week from now at end of day" do
        ann.ends_at.should be_within(1).of(UserAnnouncements[:default_ends_at])
      end
      
      it "roles" do
        ann.roles.should == Array(UserAnnouncements[:default_roles])
      end
      
      it "style" do
        ann.style.should == UserAnnouncements[:default_style]
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
