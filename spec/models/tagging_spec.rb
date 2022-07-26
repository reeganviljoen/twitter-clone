require 'rails_helper'

RSpec.describe Tagging, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:tweet) }
  it { should belong_to(:tag) }
end