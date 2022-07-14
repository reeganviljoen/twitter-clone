class CommentsController < ApplicationController

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @comments = @tweet.comments.order(created_at: :desc)
  end

  def show 
    @comment = Tweet.find(params[:id])
  end
  
  def new
    @tweet = Tweet.find(params[:tweet_id])
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
    permitted_params = params.permit(:content)
    
    permitted_params.merge!(
      user_id: current_user.id
    )
  end
end
