require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  let(:user_attributes)  { attributes_for(:user) }
  let(:user) { User.create(user_attributes)}

  let(:tweet_attributes) { attributes_for(:tweet) }
  before { sign_in user }

  describe 'GET /tweets' do
    before { get tweets_path }
    
    it 'returns a response' do
      expect(response).to be_successful
    end

    it 'assigns @tweets' do
      expect(assigns(:tweets)).to be_a(ActiveRecord::Relation)
    end
  end

  describe 'GET /tweets/new' do
    before { get new_tweet_path }

    it 'returns a response' do
      expect(response.body).not_to be_empty
    end

    it 'assigns @tweet' do
      expect(assigns(:tweet)).to be_a(Tweet)
    end
  end

  describe 'POST /tweets' do
    context 'when it is valid tweet' do
      before { post tweets_path, params: {tweet: tweet_attributes} }
      
      it 'redirects back to new tweets path' do
        expect(response).to redirect_to(new_tweet_path)
      end

      it 'asigns @tweet' do
        expect(assigns(:tweet)).to be_a(Tweet)
      end
    end

    context 'when it is an invalid tweet' do
      before { post tweets_path, params: {tweet: { content: ''} } } 
      
      it 'is not succesfull' do
        expect(response).not_to be_successful
      end

      it 'asigns @tweet' do
        expect(assigns(:tweet)).to be_a(Tweet)
      end
    end
  end

  describe 'DELETE /tweet/:id' do
    context 'when the tweet exists' do
      let(:tweet) do
         user.tweets.create(tweet_attributes)
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
