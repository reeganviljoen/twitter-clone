require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:user) { create(:user)}
  let(:tweet) { create(:tweet, user_id: user.id) }

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

  describe 'POST tweets/:tweet_id/like' do
    before { post tweet_likes_path(tweet), params: {tweet_id: tweet.id} }
    
    it 'redirects to tweets/:tweet_id/like/new' do
      expect(response).to redirect_to(new_tweet_like_path(tweet))
    end

    it 'asigns @like' do
      expect(assigns(:like)).to be_a(Like)
    end
  end

  describe 'DELETE tweets/:tweet_id' do
    let(:like) { user.likes.last }

    before do
      post tweet_likes_path(tweet), params: {tweet_id: tweet.id}
      delete tweet_like_path(tweet, like)
    end
    
    it 'assisns @like' do
      expect(assigns(:like)).to eq(like)
    end

    it 'assisns @tweet' do
      expect(assigns(:tweet)).to eq(tweet)
    end

    it 'redirects to tweets/:tweet_id/likes/new' do
      expect(response).to redirect_to(new_tweet_like_path(tweet))
    end 

    it 'deletes the like' do
      expect(Like.where(id: like.id).blank?).to be_truthy
    end
  end
end  