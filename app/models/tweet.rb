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
  
  has_many :mentions
  accepts_nested_attributes_for :mentions
  
  has_rich_text :content
  validates_presence_of :content
  after_destroy_commit lambda {
    broadcast_remove_to 'tweets', target: "#{dom_id self}"
  } 

  scope :created_at_desc, -> { order(created_at: :desc) }

  scope :followed_tweets, ->(current_user) {left_joins(user: :followers).where(followers: {follower_id: current_user.id}).or(Tweet.where(user_id: current_user.id))}

  scope :tagged_tweets, -> (current_user) { joins(taggings: :tag).where(tag: {body: current_user.tags.pluck(:body)})}
  
  # @tweets = Tweet.left_joins(:mentions).where(mentions: {user_name: current_user.handle}).or(Tweet.where(user_id: current_user.id)).created_at_desc
  scope :mentioned_tweets, -> (current_user) { left_joins(:mentions).where(mentions: {user_name: current_user.handle}).or(Tweet.where(user_id: current_user.id))}
  def tags_attributes=(tags_attributes)
	  self.tags = Tag.where_or_create(tags_attributes) 
  end
  
  def liked?(user)
    likes.where(user_id: user.id).any?
  end
end
