require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets) }
  it { should have_many(:likes) }
  it { should have_many(:followers) }
  it { should have_many(:followees) }
  it { should have_many(:taggings) }
  it { should have_many(:tags) }
  it { should accept_nested_attributes_for(:tags) }
  it { should have_one(:avatar_attachment) }
  it { should have_one(:background_image_attachment)}
  
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:phone) }
  it { should validate_length_of(:description) }
  
  
end