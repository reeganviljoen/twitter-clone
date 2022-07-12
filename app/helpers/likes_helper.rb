module LikesHelper
  def already_liked?(tweet)
    Like.where(user_id: current_user.id).where(tweet_id: tweet.id).present?
  end 
end
