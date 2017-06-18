require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'users#new' do
    it 'should successfully show the new user page' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
