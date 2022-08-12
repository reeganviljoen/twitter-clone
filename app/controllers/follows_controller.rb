class FollowsController < ApplicationController
  def create
    current_user.followees.create!(followee_id: params[:user_id])
    redirect_to user_path(params[:user_id])
  end

  def destroy
    begin
      followee = current_user.followees.find_by(followee_id: params[:user_id])
      followee.destroy
    rescue ActiveRecord::RecordNotDestroyed, ActiveRecord::RecordNotFound
      redirect_to user_path(params[:user_id]), status: :see_other
    end
  end
end
