require 'rails_helper'

RSpec.describe ClubsController, type: :controller do

  describe 'clubs#index action' do
    it 'should succesfully show the page' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
