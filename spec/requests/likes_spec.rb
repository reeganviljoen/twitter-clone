require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:user_attributes)  { attributes_for(:user) }
  let(:user) { User.create(user_attributes)}

  let(:tweet_attributes) { attributes_for(:tweet)}
  let(:tweet) { user.tweets.create(tweet_attributes) }
  before { sign_in user }

  describe 'GET tweets/:tweet_id/like/new' do
    it 'returns a response' do
      get new_tweet_like_path(tweet), params:{type: 'comment'}
      expect(response.body).to_not be_empty
    end
  end
end