 class CommentsController < ApplicationController
  before_action :set_tweet, only: [:index, :new]
  before_action :extract_mentions_and_tags, only: :create

  def index
    @comments = @tweet.comments.descending_tweets
  end
   
  def new
    @comment = @tweet.comments.new()
  end

  def create 
    tweet = Tweet.find(params[:tweet_id])
    @comment = tweet.comments.new(comment_params)
    if @comment.save
      redirect_to tweet_path(tweet)
    else 
      render :new, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    permitted_params = params.permit(:content, :tweet_type)
    
    permitted_params.merge!(
      user_id: current_user.id
    )
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id]) 
  end
end
