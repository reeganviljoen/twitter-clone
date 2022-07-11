class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index 
    @tweets = Tweet.all
  end
  
  def show 
    @tweet = Tweet.find(params[:id])
  end

  def new 
    @tweet = current_user.tweets.new
  end

  def create
    begin
      @tweet = current_user.tweets.create!(tweet_params)
      redirect_to @tweet
    rescue
      render :new, status: :unprocessable_entity
    end
  end

  def edit 
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    
    if @tweet.update(tweet_params) do
      redirect_to @tweet
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
