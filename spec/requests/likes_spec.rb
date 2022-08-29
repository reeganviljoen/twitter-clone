require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let!(:user) { create(:user)}
  let!(:tweet) { create(:tweet, user_id: user.id) }

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

  describe 'GET tweets/:tweet_id/like' do
    before { post tweet_likes_path(tweet), params: {tweet_id: tweet.id} }
    
    it 'redirects to tweets/:tweet_id/like/new' do
      expect(response).to redirect_to(new_tweet_like_path(tweet))
    end

    it 'asigns @like' do
      expect(assigns(:like)).to be_a(Like)
    end
  end
end