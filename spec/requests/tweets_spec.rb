require 'rails_helper'


RSpec.describe 'Tweets', type: :controller do
  let(:user_attr) {attributes_for(:user)}
  let(:user) {build(:user)}

  it 'signs in user' do
    sign_in @user
  end

end
