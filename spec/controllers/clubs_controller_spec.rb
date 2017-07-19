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

  describe 'clubs#edit action' do
    it 'should load the page for an existing club' do
      club = FactoryGirl.create(:club)
      edit_club_path(club)
      expect(response).to have_http_status(:success)
    end

    it 'should return to the club listing page if a club is not found' do
      get :edit, params: { id: 'noclub' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'clubs#update action' do
    it 'should update successfully with valid input' do
      club = FactoryGirl.create(:club)
      club.update_attributes(name: 'Augusta Country Club EDIT')
      expect(club.name).to eq('Augusta Country Club Edit')
      expect(response).to have_http_status(:success)
    end

    it 'should reload the edit page with if changes are invalid' do

    end
  end

  describe 'clubs#destroy action' do
    it 'should delete a club that exists' do
      club = FactoryGirl.create(:club)
      club_count = Club.count
      club.destroy
      expect(Club.count).to eq(club_count - 1)
    end
  end

end
