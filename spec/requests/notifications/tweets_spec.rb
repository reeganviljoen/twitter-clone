require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET notifications/tweets' do
    it 'returns a response' do
      get '/notifications/tweets'
      expect(response.body).not_to be_empty
    end
  end
end
