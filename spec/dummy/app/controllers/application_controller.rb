class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  
  def current_user
    User.find(session[:user_id])
  end
  helper_method :current_user
  
  def ensure_admin_user
    unless current_user.has_role?('admin')
      redirect_to root_url, alert: 'Not authorized'
    end
  end
  
end
