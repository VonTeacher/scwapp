require 'rails_helper'

RSpec.describe ClubsController, type: :controller do

  describe 'clubs#index action' do
    it 'should succesfully show the page' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'clubs#new action' do
    it 'should succesfully show the page to add a new club' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'clubs#create action' do
    it 'should succesfully create a new club in the database' do
      post :create, params: { club: { name: 'USGA Course #1', city: 'Somewhere', state: 'AZ' } }
      expect(response).to redirect_to root_url

      club = Club.last
      expect(club.name).to eq 'USGA Course #1'
      expect(club.city).to eq 'Somewhere'
      expect(club.state).to eq 'AZ'
    end

    it 'should refuse validation on empty names' do
      post :create, params: { club: { name: '', city: 'Somewhere', state: 'AZ' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Club.count).to eq 0
    end

    it 'should refuse validation on empty city' do
      post :create, params: { club: { name: 'USGA Course #1', city: '', state: 'AZ' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Club.count).to eq 0
    end

    it 'should refuse validation on empty state' do
      post :create, params: { club: { name: 'USGA Course #1', city: 'Somewhere', state: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Club.count).to eq 0
    end

    it 'should only accept two letter states' do
      post :create, params: { club: { name: 'USGA Course #1', city: 'Somewhere', state: 'A' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Club.count).to eq 0
    end

  end

end
