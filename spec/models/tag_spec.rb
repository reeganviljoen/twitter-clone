require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_many(:taggings) }
  it { should have_many(:tweets) }
  it { should validate_uniqueness_of(:body) }
end