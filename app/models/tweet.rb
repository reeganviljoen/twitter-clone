class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  has_rich_text :content
end
