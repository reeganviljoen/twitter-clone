require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:user_attributes)  { attributes_for(:user) }
  let(:user) { User.create(user_attributes)}

  let(:tweet_attributes) { attributes_for(:tweet)}
  let(:tweet) { user.tweets.create(tweet_attributes) }
  before { sign_in user }

  describe 'GET tweets/:tweet_id/like/new' do
    before { get new_tweet_like_path(tweet), params:{type: 'comment'} }

    it 'is succesfull' do
      expect(response).to be_successful
    end

    it 'asigns @tweet' do
      expect(assigns(:tweet)).to be_a(Tweet)
    end

    it 'asigns @like' do
      expect(assigns(:like)).to be_a(Like)
    end
  end
end