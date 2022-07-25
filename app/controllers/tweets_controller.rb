class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index 
    followees = current_user.followees.pluck(:followee_id)
    @tweets = Tweet.followed_tweets(followees).descending_tweets
  end

  def new 
    @tweet = current_user.tweets.new
  end

  def create
    respond_to do |format|
      @tweet = current_user.tweets.new(tweet_params)
      if @tweet.save
        format.html{redirect_to root_path}
      else
        format.html{render :new, status: :unprocessable_entity}
      end
      format.turbo_stream
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    respond_to do |format|
      begin
        @tweet.destroy
        format.html {redirect_to root_path}
      rescue
        format.html{render :index, status: :unprocessable_entity}
      end
      format.turbo_stream
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content, :tweet_type)
  end
end
