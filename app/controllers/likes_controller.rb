class LikesController < ApplicationController
  def new
    @tweet = Tweet.find(params[:tweet_id])
    if @tweet.likes.find_by(tweet_id: @tweet.id).present?
      @like = @tweet.likes.find_by(tweet_id: @tweet.id)
    else
      @like = current_user.likes.new(tweet_id: params[:tweet_id])
    end
  end

  def create
    begin
      @like = current_user.likes.create!(like_params)
      if params[:like][:comment] == 'true'
        redirect_to new_tweet_like_path(@like.tweet, comment: true), status: :see_other
      else
        redirect_to new_tweet_like_path(@like.tweet), status: :see_other
      end
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
    params.require(:like).permit(:tweet_id)
  end
end
