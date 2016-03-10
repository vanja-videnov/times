module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def is_admin?
    current_user.admin == true
  end

  def is_owner?(post_id)
    Post.is_owner?(current_user.id, post_id)
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end

# User.create() # User|false
# User.create!() # User| raise ActiveRecord::SomeError
#
# User.find() # User| raise ActiveRecord::SomeError
# User.find_by!

# a = {a: 1}
# b = {b: 2}
#
# a.merge(b) # => a + b
# a = a.merge(b)
# a.merge!(b)