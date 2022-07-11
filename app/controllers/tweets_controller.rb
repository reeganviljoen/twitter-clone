class TweetsController < ApplicationController
  def new 
    @tweet = current_user.new
  end

  def create
    begin
      @tweet = current_user.create!(tweet_params)
      redirect_to @tweet
    rescue
      render :new, status: :unprocessable_entity
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
