class LikesController < ApplicationController
  def new
    @tweet = Tweet.find(params[:tweet_id])
    
    @like = current_user.likes.find_or_initialize_by(tweet_id: @tweet.id)
  end

  def create
    begin
      @like = current_user.likes.create!(like_params)
      redirect_to new_tweet_like_path(@like.tweet, comment: params[:comment] == 'true'), status: :see_other
    rescue
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    if params[:comment] == 'true'
      redirect_to new_tweet_like_path(@like.tweet, comment: true), status: :see_other
    else
      redirect_to new_tweet_like_path(@like.tweet), status: :see_other
    end
    @like.destroy
  end

  private
  def like_params
    params.permit(:tweet_id)
  end
end
