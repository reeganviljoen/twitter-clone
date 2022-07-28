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
      params[:tweet][:mentions_attributes].each do |key, mention|
        if mention[:user].present?  
          begin
            user = Profile.find_by!(first_name: mention[:user]).user
            @tweet.mentions.create(user_id: user.id)
          rescue ActiveRecord::RecordNotFound
            flash.notice = 'mention not valid'
          end
        end
      end
      redirect_to new_tweet_path
    else
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
    permited_params = params.require(:tweet).permit(:content, :tweet_type)
    
    tag_attributes = []
    params[:tweet][:tags_attributes].each do |key, tag_attribute|
      tag_attributes << {body: tag_attribute[:body]}
    end

    permited_params.merge!(tags_attributes: tag_attributes)
  end
end
