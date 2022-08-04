class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tweets, through: :taggings
  validates :body, uniqueness: true
end