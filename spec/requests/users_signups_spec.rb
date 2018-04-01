require 'rails_helper'
require 'support/test_helper'

RSpec.describe "UsersSignups", type: :request do

  describe 'invalid signups' do

    it 'should deny #create' do
      get signup_path
      expect {
        post '/users', params: { user: { username: 'testuser', email: 'testuser@test.com', password: 'foo', password_confirmation: 'bar' } }
      }.to_not change(User, :count)
      assert_select 'div#error-explain'
      assert_select 'div.field_with_errors'
    end

  end

  describe 'valid signups' do
    it 'should allow #create' do
      get signup_path
      expect{
        post '/users', params: { user: { username: 'testuser', email: 'testuset@test.com', password: 'testpass', password_confirmation: 'testpass' } }
      }.to change(User, :count).by 1
      follow_redirect!
      assert_select 'div.alert-notice'
      assert test_is_logged_in?
    end
  end

end
