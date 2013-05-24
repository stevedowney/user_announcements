class ApplicationController < ActionController::Base
  CurrentUserMethodNotDefinedError = Class.new(StandardError)
  
  protect_from_forgery
  
  private
  
  def current_user
    User.find(session[:user_id])
  end
  helper_method :current_user
  
  def ensure_current_user
    ENV['ENSURE_CURRENT_USER_TEST'] == 'true' ? will_raise_name_error : current_user
  rescue NameError
    raise CurrentUserMethodNotDefinedError, "You must have a current_user method"
  end
  
end
