class Explore::TweetsController < ApplicationController
  before_action :authenticate_user!

  def index 
    tags = current_user.tags.pluck(:id)
    @tweets = Tweet.tagged_tweets(tags).created_at_desc
  end
end
