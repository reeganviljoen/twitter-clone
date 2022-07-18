

class Tweet < ApplicationRecord

  belongs_to :user
  has_many :likes, dependent: :destroy

  
  has_many :comments,  -> { where(tweet_type: 'comment')}, dependent: :destroy, class_name: 'Tweet', 
  foreign_key: 'tweet_id', inverse_of: 'tweet'

  has_many :retweets,-> { where(tweet_type: 'retweet')},
   dependent: :destroy, class_name: 'Tweet', foreign_key: 'tweet_id', inverse_of: 'tweet'

  belongs_to :tweet, class_name: 'Tweet', optional:  true

  scope :descending_tweets, -> { order(created_at: :desc) }

  has_rich_text :content
  
  def liked?(user)
    likes.where(user_id: user.id).any?
  end
end
