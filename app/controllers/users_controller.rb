class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.descending_tweets
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.taggings.destroy_all
    if @user.update(user_params)
      redirect_to @user 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit( :first_name, :last_name, :background_image, :avatar, :description, :phone, tags_attributes: :body)
  end
end
