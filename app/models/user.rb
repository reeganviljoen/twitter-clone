class User < ApplicationRecord
  has_many :tweets , dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :followers, foreign_key: 'followee_id', class_name: 'Follow'

  has_many :followees, foreign_key: 'follower_id', class_name: 'Follow'

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
