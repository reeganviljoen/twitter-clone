class Mention < ApplicationRecord
  belongs_to :mentioner, class_name: 'User'
  belongs_to :mentioned, class_name: 'User'
end
