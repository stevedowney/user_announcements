class Admin::BaseController < ApplicationController
  before_filter :ensure_admin_user

  private
  
  def ensure_admin_user
    # FIXME
    # unless current_user.has_role?(:admin)
    #   redirect_to root_path
    # end
  end
end
