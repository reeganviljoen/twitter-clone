class Explore::TweetsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @tweets = Tweet.tagged_tweets(current_user).created_at_desc
  end
end
