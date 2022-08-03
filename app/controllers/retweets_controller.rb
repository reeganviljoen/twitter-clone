class RetweetsController < ApplicationController
  before_action :extract_mentions_and_tags, only: :create

  def new
    @tweet = Tweet.find(params[:tweet_id])
    @retweet = @tweet.retweets.new()
  end

  def create 
    tweet = Tweet.find(params[:tweet_id])
    @retweet = tweet.retweets.new(retweet_params)
    if @retweet.save
      redirect_to root_path
    else 
      render :new, status: :unprocessable_entity
    end
  end

  private
  def retweet_params
    permitted_params = params.permit(:content, :tweet_type)
    
    permitted_params.merge!(user_id: current_user.id)
  end 
end
