class LikesController < ApplicationController
  def new
    @like = current_user.likes.new(tweet_id: params[:tweet_id])
  end

  def create
    begin
      @like = current_user.likes.create!(like_params)
      if params[:like][:comment] == 'true'
        redirect_to tweet_comment_path(@like.tweet.tweet, @like.tweet)
      else
        redirect_to tweet_path(@like.tweet)
      end
    rescue
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    if params[:comment] == 'true'
      redirect_to tweet_comment_path(@like.tweet.tweet, @like.tweet), status: :see_other
    else
      redirect_to tweet_path(@like.tweet), status: :see_other
    end
    @like.destroy
  end

  private
  def like_params
    params.require(:like).permit(:tweet_id)
  end
end
