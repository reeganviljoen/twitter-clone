class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :tweets , dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :followers, foreign_key: 'followee_id', class_name: 'Follow'
  has_many :followees, foreign_key: 'follower_id', class_name: 'Follow'

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy
  accepts_nested_attributes_for :tags
  
  has_many :mentions , class_name: 'Mention', inverse_of: :mentioner
  has_many :notifications , class_name: 'Mention', inverse_of: :mentioned

  def tags_attributes=(tags_attributes)
    tags_attributes.each do |tag_attribute| 
      tag = Tag.find_or_create_by!(tag_attribute)
      self.tags << tag
    end	  
  end

  def follow(followee_id)
    followees.create!(followee_id: followee_id)
  end

  def unfollow(followee_id)
    followee = followees.find_by(followee_id: followee_id)
    followee.destroy
  end

  def following(followee_id)
    begin
      followee = followees.find_by(followee_id: followee_id)
      if followee.nil? then raise ActiveRecord::RecordNotFound else return true end
    rescue ActiveRecord::RecordNotFound
      return false
    end
  end
end
