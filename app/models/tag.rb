class Tag < ApplicationRecord
  has_many :tagings
  has_many :tweets, through: :tagings
  # has_and_belongs_to_many :tweets
  validates :body, uniqueness: true
end
