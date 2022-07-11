class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes

  has_rich_text :content
end
