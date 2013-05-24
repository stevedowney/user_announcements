class User < ActiveRecord::Base
  attr_accessible :name
  
  def has_role?(role)
    return true if role.blank?
    
    (role == 'admin' && id == 1)
    
  end
end