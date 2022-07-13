class CommentsController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @comments = @tweet.comments.all
  end

  def show 
    tweet = Tweet.find(params[:tweet_id])
    @comment = tweet.comments.find(params[:id])
  end
  
  def new
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.new()
  end

  def create 
    tweet = Tweet.find(params[:tweet_id])
    @comment = tweet.comments.create!(comment_params)
  end

  private
  def comment_params
    params[:user_id] = current_user.id
    params.permit(:user_id, :content)
  end
end
