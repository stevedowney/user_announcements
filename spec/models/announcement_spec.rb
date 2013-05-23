require 'spec_helper'

describe Announcement do
  
  def new_announcement(attributes={})
    Announcement.new_with_defaults.tap do |ann|
      ann.message = 'the message'
      ann.attributes = attributes
    end
  end
  
  let(:current_announcement) { new_announcement }
  let(:past_announcement) { new_announcement(ends_at: 1.minute.ago) }
  let(:future_announcement) { new_announcement(starts_at: 1.minute.from_now) }
  
  describe '#current?' do
    it "current" do
      current_announcement.should be_current
    end
    
    it "not current" do
      past_announcement.should_not be_current
      future_announcement.should_not be_current
    end
  end
  
  describe '#status_order' do
    it "based on status" do
      future_announcement.status_order.should == 1
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
      def new_announcement(attributes)
        Announcement.new_with_defaults.tap do |ann|
          ann.message = 'the message'
          ann.attributes = attributes
          ann.save!
        end
      end
      
      it "only gets active" do
        active = new_announcement(active: true)
        inactive = new_announcement(active: false)
        Announcement.active.should == [active]
      end
    end
  end
  
end
