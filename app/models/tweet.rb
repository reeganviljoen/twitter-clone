require "sti_preload"

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :retweets, dependent: :destroy

  scope :descending_tweets, -> { order(created_at: :desc) }

  has_rich_text :content
  
  def liked?(user)
    likes.where(user_id: user.id).any?
  end
end
