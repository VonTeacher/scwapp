require 'rails_helper'

RSpec.describe TeesController, type: :controller do

  describe 'tees#new action' do
    it 'should successfully show the new tee page' do
      club = FactoryGirl.create(:club)
      get :new, params: { club_id: club.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'tees#create action' do
    it 'should successfully create a new tee' do
      club = FactoryGirl.create(:club)
      tee = FactoryGirl.create(:tee)
      post :create, params: { tee: tee.attributes, club_id: club.id }
      expect(response).to redirect_to club_url(club)

      tee = Tee.last
      expect(tee.color).to eq('I-O Champ')
      expect(tee.usga_course_rating_18).to be_within(0.1).of(73.6)
      expect(tee.slope_rating_18).to eq(133)
      expect(tee.front_9_rating).to be_within(0.1).of(37.8)
      expect(tee.front_9_slope).to eq(137)
      expect(tee.back_9_rating).to be_within(0.1).of(35.9)
      expect(tee.back_9_slope).to eq(129)
      expect(tee.bogey_rating).to be_within(0.1).of(98.3)
      expect(tee.gender).to eq('M')
      expect(tee.club_id).to eq(club.id)
    end
  end

end
