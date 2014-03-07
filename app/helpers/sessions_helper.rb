module SessionsHelper

  def sign_in(user)
    remember_token = User.new_random_token
    cookies.permanent[:remember_token] = remember_token
    user.update(remember_token: User.hash(remember_token))
    self.current_user = user
    flash[:notice] = "Signed in successfully"
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find(remember_token: remember_token)
  end

  def signed_in?
    !current_user.nil? && current_user.confirmed?
  end

  def sign_out
    current_user.update(remember_token: User.hash(User.new_random_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end