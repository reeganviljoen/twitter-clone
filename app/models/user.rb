class User < ApplicationRecord
  has_many :tweets , dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :followeds_followers

  has_many :followers, through: :followeds_followers
  has_many :followeds, through: :followeds_followers

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
