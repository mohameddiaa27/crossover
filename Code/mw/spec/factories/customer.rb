FactoryGirl.define do
  factory :customer do
    email Faker::Internet.email
    password Faker::Name.unique.name
    name Faker::Name.name

    trait :another_email do
    	email Faker::Internet.email
  	end

  	factory :another_customer, traits: [:another_email]
  end
end
