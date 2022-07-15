class RetweetsController < ApplicationController
  def new
    @tweet = Tweet.find(params[:tweet_id])
    @retweet = @tweet.retweets.new()
  end

  def create 
    binding.pry
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
    permitted_params = params.permit(:content)
    
    permitted_params.merge!(
      user_id: current_user.id
    )
  end
end
