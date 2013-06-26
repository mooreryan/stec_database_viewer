module UsersHelper
  # for some reason this has to be duplicated from sessions_helper.rb
  def sign_in(user)
    # technically this sets expiration to 20.years.from_now
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user # ie current_user=(...)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user?(user)
    user == current_user
  end 


end
