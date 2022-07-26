class Tweet < ApplicationRecord
  include ActionView::RecordIdentifier
  
  belongs_to :user
  has_many :likes, dependent: :destroy

  
  has_many :comments,  -> { where(tweet_type: 'comment')}, 
  dependent: :destroy, class_name: 'Tweet', foreign_key: 'tweet_id', inverse_of: 'tweet'

  has_many :retweets,-> { where(tweet_type: 'retweet')},
   dependent: :destroy, class_name: 'Tweet', foreign_key: 'tweet_id', inverse_of: 'tweet'

  belongs_to :tweet, class_name: 'Tweet', optional:  true

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  accepts_nested_attributes_for :tags
  
  def tags_attributes=(tags_attributes)
    tags_attributes.each do |tag_attribute| 
      tag = Tag.find_or_create_by!(tag_attribute)
      self.tags << tag
    end	  
  end

  after_create_commit lambda {
    broadcast_prepend_later_to 'tweets', target:'tweets'
  }
  
  after_destroy_commit lambda {
    broadcast_remove_to 'tweets', target: "#{dom_id self}"
  } 

  scope :descending_tweets, -> { order(created_at: :desc) }

  scope :followed_tweets, -> (followees) {where(user_id: followees)}

  has_rich_text :content
  
  def liked?(user)
    likes.where(user_id: user.id).any?
  end
end
