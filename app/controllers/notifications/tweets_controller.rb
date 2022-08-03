class Notifications::TweetsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @tweets = Tweet.joins(:mentions).where(mentions: { user_name: current_user.handle}).descending_tweets
  end
end
