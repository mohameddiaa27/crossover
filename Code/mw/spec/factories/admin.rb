FactoryGirl.define do
  factory :admin do
    email 'admin@email.com'
    password Faker::Name.unique.name
    name 'Admin Name'

    trait :random do
	    email Faker::Internet.email
	    password Faker::Name.unique.name
	    name Faker::Name.name
    end
  end
end