class Mention < ApplicationRecord
  belongs_to :tweet
  belongs_to :user, foreign_key: :user_name, primary_key: :handle, optional: true
end
