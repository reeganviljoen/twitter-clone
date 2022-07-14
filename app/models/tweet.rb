class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  has_many :comments, class_name: 'Tweet', foreign_key: 'tweet_id', dependent: :destroy
  belongs_to :tweet, class_name: 'Tweet', optional: true

  has_rich_text :content
  
  def liked?(user)
    likes.where(user_id: user.id).any?
  end
end
