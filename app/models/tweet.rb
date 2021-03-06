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
  
  after_destroy_commit lambda {
    broadcast_remove_to 'tweets', target: "#{dom_id self}"
  } 

  scope :descending_tweets, -> { order(created_at: :desc) }

  scope :followed_tweets, -> (followees) {where(user_id: followees)}

  scope :tagged_tweets, -> (tags) { joins(taggings: :tag).where(tag: {id: tags})}

  def tags_attributes=(tags_attributes)
    tags_attributes.each do |tag_attribute| 
      if tag_attribute[1][:body].present? 
        tag = Tag.find_or_create_by!(tag_attribute[1])
        self.tags << tag
      end
    end	  
  end
  
  def liked?(user)
    likes.where(user_id: user.id).any?
  end
end
