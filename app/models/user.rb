class User < ApplicationRecord
  has_many :tweets , dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :follower_join, foreign_key: 'follower_id', class_name: 'FollowedsFollower'
  has_many :followers, through: :follower_join

  has_many :followed_join, foreign_key: 'followed_id', class_name: 'FollowedsFollower'
  has_many :followers, through: :followed_join

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
