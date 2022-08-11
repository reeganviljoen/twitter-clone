require 'rails_helper'


RSpec.describe 'Tweets', type: :request do
  let(:user_attributes)  { attributes_for(:user) }
  let(:user) { User.create(user_attributes)}

  let(:tweet_attributes) { attributes_for(:tweet) }
  before { sign_in user }

  describe 'GET /tweets' do
    it 'returns a response' do
      get '/tweets'
      expect(response.body).not_to be_empty
    end
  end

  describe 'GET /tweets/new' do
    it 'returns a response' do
      get '/tweets/new'
      expect(response.body).not_to be_empty
    end
  end

  describe 'POST /tweets' do
    context 'when it is valid tweet' do
      it 'redirects back to new tweets path' do
        post '/tweets', params: {tweet: tweet_attributes}
        expect(response).to redirect_to(new_tweet_path)
      end
    end

    context 'when it is an invalid tweet' do
      it 'renders an unprocessable entity staus code' do
        post '/tweets', params: {tweet: { content: ''}}
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /tweet/:id' do
    context 'when the tweet exists' do
      let(:tweet) do
         tweet_attributes[:user_id] = user.id
         Tweet.create(tweet_attributes)
      end

      it 'redirects to root path' do
        delete "/tweets/#{tweet.id}"

        expect(response).to have_http_status(302)
      end
    end

    context 'when the tweet does not exist' do
      it 'returns a http staus code unprocessable_entity' do
        delete "/tweets/0"
        expect(response).to have_http_status(422)
      end
    end
  end
end
