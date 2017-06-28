module TestHelpers

  def test_is_logged_in?
    !session[:user_id].nil?
  end

end

RSpec.configure do |c|
  c.include TestHelpers
end
