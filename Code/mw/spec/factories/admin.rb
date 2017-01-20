FactoryGirl.define do
  factory :admin do
    email Faker::Internet.email
    password Faker::Name.unique.name
    name Faker::Name.name
  end
end
