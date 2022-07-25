class User < ApplicationRecord
  has_many :tweets , dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :followers, foreign_key: 'followee_id', class_name: 'Follow'

  has_many :followees, foreign_key: 'follower_id', class_name: 'Follow'

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
