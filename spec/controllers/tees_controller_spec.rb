require 'rails_helper'

RSpec.describe TeesController, type: :controller do

  describe 'tees#new action' do
    it 'should successfully show the new tee page' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'tees#create action' do
    it 'should successfully create a new tee' do
      post :create, params: { tee: { color: 'Blue', usga_course_rating_18: 70.5, slope_rating_18: 122, front_9_rating: 35.0, front_9_slope: 119, back_9_rating: 35.5, back_9_slope: 124, bogey_rating: 93.1, gender: 'M', club_id: 1 } }
      expect(response).to redirect_to tees_url

      tee = Tee.last
      expect(tee.color).to eq('Blue')
      expect(tee.usga_course_rating_18).to eq(70.5)
      expect(tee.slope_rating_18).to eq(122)
      expect(tee.front_9_rating).to eq(35.0)
      expect(tee.front_9_slope).to eq(119)
      expect(tee.back_9_rating).to eq(35.5)
      expect(tee.back_9_slope).to eq(124)
      expect(tee.bogey_rating).to be_within(0.1).of(93.1)
      expect(tee.gender).to eq('M')
      expect(tee.club_id).to eq(1)
    end
  end

end
