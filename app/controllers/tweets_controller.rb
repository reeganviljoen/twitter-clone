class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index 
    followees = current_user.followees.pluck(:followee_id) << current_user.id
    @tweets = Tweet.followed_tweets(followees).descending_tweets
  end

  def new 
    @tweet = current_user.tweets.new
    5.times { @tweet.tags.build }
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
    permited_params = params.require(:tweet).permit(:content, :tweet_type)
    
    tag_attributes = []
    params[:tweet][:tags_attributes].each do |key, tag_attribute|
      tag_attributes << {body: tag_attribute[:body]}
    end

    permited_params.merge!(tags_attributes: tag_attributes)
  end
end
