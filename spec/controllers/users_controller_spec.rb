require 'rails_helper'
require 'support/test_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  describe 'users#index' do
    it 'should successfully show all users' do
      log_in_as(user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'users#new' do
    it 'should successfully show the new user page' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'users#create' do
    it 'should successfully create a new user' do
      post :create, params: { user: { username: 'test_user', email: 'test_user@test.com', password: 'testpass', password_confirmation: 'testpass' } }
      user = User.last

      expect(response).to redirect_to user
      expect(user.username).to eq 'test_user'
      expect(user.email).to eq 'test_user@test.com'
    end

    it 'should not accept a new user without a username' do
      user = FactoryGirl.create(:user)
      post :create, params: { user: { username: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should not accept a new user with a short username' do
      user = FactoryGirl.create(:user)
      user.username = 'short'
      user.save
      post :create, params: { user: user.attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should not accept a new user without an email address' do
      user = FactoryGirl.create(:user)
      user.email = ''
      user.save
      post :create, params: { user: user.attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should not accept a new user with an invalid email address' do
      user = FactoryGirl.create(:user)
      user.email = 'user@example,com'
      user.save
      post :create, params: { user: user.attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'users#show action' do
    it 'should show the page for an existing user' do
      log_in_as(user)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it 'should redirect and alert if a user does not exist' do
      log_in_as(user)
      get :show, params: { id: 'noid' }
      expect(response).to redirect_to root_url
    end
  end

end
