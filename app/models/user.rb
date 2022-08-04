class User < ApplicationRecord
  devise  :database_authenticatable, 
          :registerable, 
          :recoverable, 
          :rememberable, 
          :validatable,
          :confirmable

  has_many :tweets , dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :followers, foreign_key: 'followee_id', class_name: 'Follow'
  has_many :followees, foreign_key: 'follower_id', class_name: 'Follow'

  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy
  accepts_nested_attributes_for :tags, allow_destroy: true
  
  has_many :mentions, foreign_key: :user_name, primary_key: :handle

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :phone,      presence: true
  validates :description, length: { maximum: 300 }
  
  has_one_attached :avatar
  has_one_attached :background_image

  def tags_attributes=(tags_attributes)
    self.tags = Tag.where_or_create(tags_attributes)
  end

  def following(followee_id)
    followees.find_by(followee_id: followee_id).present?
  end
end
