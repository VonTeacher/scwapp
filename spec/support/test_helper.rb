module TestHelpers

  # Return true if a test user is logged in
  def test_is_logged_in?
    !session[:user_id].nil?
  end

  # Log in as a particular test user
  def log_in_as user
    session[:user_id] = user.id
  end

  def log_in_as_test(user, password: 'testpass', remember_me: '1')
    post login_path, params: { session: { username: user.username, password: password, remember_me: remember_me } }
  end

end

RSpec.configure do |c|
  c.include TestHelpers
end
