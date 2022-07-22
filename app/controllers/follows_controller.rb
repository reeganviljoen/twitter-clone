class FollowsController < ApplicationController
  def create
    FollowedsFollower.create!(followed_id: params[:user_id], follower_id: params[:follower_id])
  end
end
