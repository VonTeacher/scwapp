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
      club = FactoryGirl.create(:club)
      post :create, params: { club: club.attributes }
      expect(response).to redirect_to root_url

      club = Club.last
      expect(club.name).to eq 'Augusta Country Club'
      expect(club.city).to eq 'Augusta'
      expect(club.state).to eq 'GA'
    end

    it 'should invalidate clubs without names' do
      club = FactoryGirl.create(:club)
      club.name = ''
      club.save
      post :create, params: { club: club.attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should invalidate clubs without cities' do
      club = FactoryGirl.create(:club)
      club.city = ''
      club.save
      post :create, params: { club: club.attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should invalidate clubs without a state' do
      club = FactoryGirl.create(:club)
      club.state = ''
      club.save
      post :create, params: { club: club.attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should invalidate clubs whose state is not 2 letters' do
      club = FactoryGirl.create(:club)
      club.state = 'GAA'
      club.save
      post :create, params: { club: club.attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end

  end

  describe 'clubs#show action' do
    it 'should successfully show a clubs detail page' do
      club = FactoryGirl.create(:club)
      get :show, params: { id: club.id }
      expect(response).to have_http_status(:success)
    end

    it 'should return 404 error if the club is not found' do
      get :show, params: { id: 'noclub' }
      expect(response).to have_http_status(:not_found)
    end
  end

end
