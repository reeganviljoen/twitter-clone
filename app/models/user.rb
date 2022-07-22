class User < ApplicationRecord
  has_many :tweets , dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :followed_followers

  has_many :followers, through: :followed_followers
  has_many :followeds, through: :followed_followers

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
