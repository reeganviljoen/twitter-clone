class TweetsController < ApplicationController
  def index 
    followees = current_user.followees.pluck(:followee_id) << current_user.id
    @tweets = Tweet.followed_tweets(followees).descending_tweets
  end

  def new 
    @tweet = current_user.tweets.new
    
    5.times do 
      @tweet.tags.build 
      @tweet.mentions.build 
    end
  end

  def create      
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to new_tweet_path
    else
      binding.pry
      render :new, status: :unprocessable_entity
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
    params.require(:tweet).permit(:content, :tweet_type, tags_attributes: :body, mentions_attributes: :user_name)
  end
end
