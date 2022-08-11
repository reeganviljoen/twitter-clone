FactoryBot.define do
  factory :tweet do
    content { 'Hello @reegan #tag1' }
    mentions_attributes { {} }
    tags_attributes { {} }
  end
end