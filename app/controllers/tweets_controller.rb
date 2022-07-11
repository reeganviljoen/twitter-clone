class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index 
    @tweets = Tweet.all
  end

  def new 
    @tweet = current_user.tweets.new
  end

  def create
    begin
      @tweet = current_user.tweets.create!(tweet_params)
      redirect_to root_path
    rescue
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
