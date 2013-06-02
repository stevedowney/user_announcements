require 'spec_helper'

describe UserAnnouncements::MiscHelper do

  describe '#ua_bootstrap?' do
    before { @_config = UserAnnouncements[:bootstrap] }
    after  { UserAnnouncements.config.bootstrap = @_config }
    
    it "true if params[:bootstrap] is true" do
      UserAnnouncements.config.bootstrap = false
      helper.stub(params: {bootstrap: 'true'})
      helper.should be_ua_bootstrap
      
      helper.stub(params: {bootstrap: 'false'})
      helper.should_not be_ua_bootstrap
    end
    
    it "true if config true" do
      UserAnnouncements.config.bootstrap = true
      helper.should be_ua_bootstrap
      
      UserAnnouncements.config.bootstrap = false
      helper.should_not be_ua_bootstrap
    end
  end
  
  describe '#ua_bootstrap_datetime_picker?' do
    before { @_config_bs = UserAnnouncements[:bootstrap_datetime_picker] }
    after  { UserAnnouncements.config.bootstrap = @_config_bs }

    before { @_config_dtp = UserAnnouncements[:bootstrap_datetime_picker] }
    after  { UserAnnouncements.config.bootstrap = @_config_dtp }
    
    it "true if config true" do
      UserAnnouncements.config.bootstrap = true
      UserAnnouncements.config.bootstrap_datetime_picker = true
      helper.should be_ua_bootstrap_datetime_picker
    end
    
    it "false if config false" do
      UserAnnouncements.config.bootstrap_datetime_picker = false
      helper.should_not be_ua_bootstrap_datetime_picker
    end
    
    it "false if bootstrap false" do
      UserAnnouncements.config.bootstrap = false
      UserAnnouncements.config.bootstrap_datetime_picker = true
      helper.should_not be_ua_bootstrap_datetime_picker
    end
  end
  
end