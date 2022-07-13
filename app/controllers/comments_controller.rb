class CommentsController < ApplicationController

  def new
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.new()
  end

  def create 
    tweet = Tweet.find(params[:tweet_id])
    binding.pry
    @comment = tweet.comments.create!(user_id: current_user.id)
  end
end
