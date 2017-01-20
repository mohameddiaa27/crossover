FactoryGirl.define do
  factory :agent do
    email Faker::Internet.email
    password Faker::Name.unique.name
    name Faker::Name.name

    trait :another_email do
    	email Faker::Internet.email
  	end

  	factory :another_agent, traits: [:another_email]
  end
end
