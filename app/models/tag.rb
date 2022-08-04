class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tweets, through: :taggings
  validates :body, uniqueness: true

  def self.where_or_create(tags_attributes)
    tags_attributes.map do |tag_attribute| 
      if tag_attribute[1][:body].present? 
        Tag.find_or_create_by!(tag_attribute[1])  
      end
    end.compact
  end 
end