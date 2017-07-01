require 'rails_helper'
require 'support/test_helper'

RSpec.describe "UsersLogins", type: :request do

  describe 'flash test' do

    it 'should display flash for one page view' do
      get login_path
      # assert_template has been extracted to a gem
      # expect(response).to render_template('sessions/new')
      assert_select 'input#session_username'
      assert_select 'input#session_password'
      post login_path, params: { session: { username: '', password: '' } }
      # expect(response).to reder_template('sessions/new')
      assert !flash.empty?
      get root_path
      assert flash.empty?
    end

  end

  describe 'log_out test' do

    it 'should log_in w/ valid info, then log_out' do
      user = FactoryGirl.create(:user)
      get login_path
      post login_path, params: { session: { username: user.username, password: user.password } }
      expect(test_is_logged_in?).to eq true
      expect(response).to redirect_to "/users/#{user.id}"
      follow_redirect!
      assert_select "a[href=?]", login_path, count: 0
      assert_select "a[href=?]", logout_path
      assert_select "a[href=?]", user_path(user)
      get logout_path
      expect(test_is_logged_in?).to eq false
      expect(response).to redirect_to root_url
      # Simulate a user clicking logout in a second window
      get logout_path
      follow_redirect!
      assert_select "a[href=?]", login_path
    end
  end

  describe 'remember me' do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'should login with remembering' do
      log_in_as_test(@user, remember_me: '1')
      expect(session[:user_id]).to eq @user.id
      expect(cookies['remember_token'].empty?).to eq false
    end

    it 'should login without remembering' do
      log_in_as_test(@user, remember_me: '1')
      log_in_as_test(@user, remember_me: '0')
      expect(cookies['remember_token'].empty?).to eq true
    end
  end

end
