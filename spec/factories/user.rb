FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    handle { Faker::Name.unique.name}
    description { 'Description' }
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    confirmed_at { DateTime.now }
  end
end