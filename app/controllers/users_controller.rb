class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
    5.times { @user.tags.build }
  end

  def update
    @user = User.find(params[:id])
     
    if @user.update(user_params)
      redirect_to @user 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    permited_params = params.require(:user).permit(profile_attributes: %i[first_name last_name background_image avatar description phone])
    
    tag_attributes = []
    params[:user][:tags_attributes].each do |key, tag_attribute|
      tag_attributes << {body: tag_attribute[:body]}
    end

    permited_params.merge!(tags_attributes: tag_attributes)
  end
end
