require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user_attributes)  { attributes_for(:user) }
  let(:user) { User.create(user_attributes)}
  # let(:tweets) { build_list(:tweet, 5, user_id: user.id)}
  before { sign_in user }

  describe 'GET /users/:id' do
    before { get user_path(user) }
    
    it 'returns a succesfull response' do
      expect(response).to be_successful
    end

    it 'assigns @user' do
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns @tweets' do
      expect(assigns(:tweets)).to be_a(ActiveRecord::AssociationRelation)
    end
  end

  describe 'GET /users/:id/edit' do
    before { get edit_user_path(user) } 

    it 'returns a response' do
      expect(response).to be_successful
    end

    it 'assigns @user' do
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PUT /users/:id' do 
    it 'redirects to /users/:id' do
      put user_path(user) , params: {user: user_attributes}
      expect(response).to redirect_to(user_path(user))
    end
  end
end

