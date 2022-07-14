class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @tweets = Tweet.descending_tweets
  end
  
  def show 
    @tweet = Tweet.find(params[:id])
  end

  def new 
    @tweet = current_user.tweets.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    begin
      @tweet.destroy
      redirect_to root_path
    rescue
      render :index, status: :unprocessable_entity
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
