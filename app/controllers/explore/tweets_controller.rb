class Explore::TweetsController < ApplicationController
  before_action :authenticate_user!

  def index 
    tags = current_user.tags.pluck(:id)
    @tweets = Tweet.tagged_tweets(tags).descending_tweets
  end
end
