FactoryGirl.define do
  factory :user do
    name Faker::Name.first_name + " " + Faker::Name.last_name
    email Faker::Name.first_name + "@example.com"
    password 'Happy123'
  end
end
