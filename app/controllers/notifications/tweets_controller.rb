class Notifications::TweetsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @tweets = Tweet.followed_tweets(current_user).created_at_desc
  end
end
