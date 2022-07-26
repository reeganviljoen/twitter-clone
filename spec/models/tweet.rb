require 'rails_helper'

RSpec.describe Tweet, type: :model do

  it { should belong_to(:user) }
  it { should have_many(:likes) }
  it { should have_many(:comments) }
  it { should have_many(:retweets) }
  it { should belong_to(:tweet) }
  it { should have_many(:taggings) }
  it { should have_many(:tags) }
  it { should accept_nested_attributes_for(:tags)}
end