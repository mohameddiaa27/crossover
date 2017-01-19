FactoryGirl.define do
  factory :customer do
    email 'customer@email.com'
    password Faker::Name.unique.name
    name 'Customer Name'

    trait :random do
	    email Faker::Internet.email
	    password Faker::Name.unique.name
	    name Faker::Name.name
    end
  end
end