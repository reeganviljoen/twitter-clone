class LikesController < ApplicationController
  def new
    @tweet = Tweet.find(params[:tweet_id])
    @like = current_user.likes.find_or_initialize_by(tweet_id: @tweet.id)
  end

  def create
    @like = current_user.likes.new(like_params)
    if @like.save
      redirect_to new_tweet_like_path(@like.tweet, type: params[:type]), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
      
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    begin
      @like.destroy
      redirect_to new_tweet_like_path(@like.tweet, type: params[:type]), status: :see_other
    rescue 
      render :new, status: :unprocessable_entity
    end
  end

  private
  def like_params
    params.permit(:tweet_id)
  end
end
