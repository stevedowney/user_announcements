class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_user
    User.find(session[:user_id])
  end
  helper_method :current_user
  
  def ensure_current_user
    current_user
  rescue NameError
    raise "You must have a current_user method"
  end
  
end
