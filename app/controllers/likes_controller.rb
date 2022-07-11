class LikesController < ApplicationController
  def new
    @like = current_user.likes.new(tweet_id: params[:tweet_id])
  end

  def create
    begin
      @like = current_user.likes.create!(like_params)
    rescue
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to root_path
  end

  private
  def like_params
    params.require(:like).permit(:tweet_id)
  end
end
