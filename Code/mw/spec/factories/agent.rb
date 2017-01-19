FactoryGirl.define do
  factory :agent do
    email 'agent@email.com'
    password Faker::Name.unique.name
    name 'Agent Name'

    trait :random do
	    email Faker::Internet.email
	    password Faker::Name.unique.name
	    name Faker::Name.name
    end

  end
end