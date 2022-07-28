class Notifications::TweetsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @tweets = Tweet.joins(:mentions).where(mentions: { user_id: current_user.id}).descending_tweets
  end
end
