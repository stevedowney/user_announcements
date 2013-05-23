module SupportLogin
  
  def login(user)
    visit login_path(user)
  end
  
  def create_and_login_user
    saved_user.tap do |user|
      login user
    end
  end
  
end

RSpec.configure { |c| c.include SupportLogin }