require 'rails_helper'
require 'support/test_helper'

RSpec.describe RoundsController, type: :controller do

  describe 'rounds#new action' do

    it 'should successfully load the page for an existing user' do
      user = FactoryGirl.create(:user)
      get :new, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

  end

  describe 'rounds#create action' do

    it 'should create a round and return to the user\'s profile' do
      user = FactoryGirl.create(:user)
      log_in_as user
      tee  = FactoryGirl.create(:tee)
      club = FactoryGirl.create(:club)
      post :create, params: { round: { club_id: club.id, tee_id: tee.id, user_id: user.id, adjusted_score: 100, date_played: "2017-06-25" } }
      expect(response).to redirect_to user
    end

  end

end
