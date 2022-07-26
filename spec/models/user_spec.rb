require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets) }
  it { should have_many(:likes) }
  it { should have_many(:followers) }
  it { should have_many(:followees) }
  it { should have_one(:profile) }
  it { should accept_nested_attributes_for(:profile) }
  it { should have_many(:taggings) }
  it { should have_many(:tags) }
  it { should accept_nested_attributes_for(:tags) }
end