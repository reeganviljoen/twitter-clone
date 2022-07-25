class FollowsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    redirect_to user_path(params[:user_id])
  end
end
