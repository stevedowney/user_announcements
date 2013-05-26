class Admin::BaseController < ApplicationController
  ::UserAnnouncements::AdminUserNotImplementedError = Class.new(StandardError)
  
  before_filter :check_for_ensure_admin_user
  before_filter :ensure_admin_user

  private
  
  def check_for_ensure_admin_user
    ensure_admin_user
  rescue NameError
    raise UserAnnouncements::AdminUserNotImplementedError, "your application must implement ApplicationController#ensure_admin_user"
  end
end
