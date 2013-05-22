class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_user
    User.first
  end
  helper_method :current_user
  
end
