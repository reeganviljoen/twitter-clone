class CommentsController < ApplicationController
  before_action :set_tweet, only: [:index, :new]
  
  def index
    @comments = @tweet.comments.descending_tweets
  end

  def show 
    @comment = Comment.find(params[:id])
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

  def destroy
    @comment = Comment.find(params[:id])
    begin
      @comment.destroy
      redirect_to tweet_path(@comment.tweet)
    rescue
      render :index, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    permitted_params = params.permit(:content)
    
    permitted_params.merge!(
      user_id: current_user.id
    )
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id]) 
  end
end
