class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :phone,      presence: true
  validates :description, length: { maximum: 300 }
  
  has_one_attached :avatar
  has_one_attached :background_image
end
