require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:phone) }
  it { should validate_length_of(:description) }
  it { should have_one(:avatar_attachment) }
  it { should have_one(:background_image_attachment)}
end