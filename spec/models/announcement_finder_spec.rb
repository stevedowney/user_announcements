require 'spec_helper'

describe AnnouncementFinder do
  
  def user_can_see(*args)
    AnnouncementFinder.send(:user_can_see, *args)
  end
  
  describe '.user_can_see' do
    let(:user) { mock('user') }
    
    it "true if no roles" do
      user_can_see(user, []).should be_true
    end
    
    it "true if blank role" do
      user_can_see(user, ['']).should be_true
      user_can_see(user, [nil]).should be_true
    end
    
    it "true if user has role" do
      user.should_receive(:has_role?).with('a').and_return(false)
      user.should_receive(:has_role?).with('b').and_return(true)
      user_can_see(user, ['a', 'b']).should be_true
    end
  end
  
end