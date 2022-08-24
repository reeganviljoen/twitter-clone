class Notifications::TweetsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @tweets = Tweet.joins(:mentions).where(mentions: {user_name: current_user.handle}).or(Tweet.where(tweet.user_id: current_user.id)).created_at_desc
  end
end
