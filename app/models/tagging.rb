class Tagging < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tweet, optional: true
  belongs_to :tag
end
