require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user_attributes)  { attributes_for(:user) }
  let(:user) { User.create(user_attributes)}

  before { sign_in user }

  describe 'GET /users/:id' do
    it 'returns a response' do
      get user_path(user)
      expect(response.body).to_not be_empty
    end
  end

  describe 'GET /users/:id/edit' do
    it 'returns a response' do
      get edit_user_path(user)

      expect(response.body).not_to be_empty
    end
  end

  describe 'PUT /users/:id' do 
    it 'redirects to /users/:id' do
      put user_path(user) , params: {user: user_attributes}
      expect(response).to redirect_to(user_path(user))
    end
  end
end

