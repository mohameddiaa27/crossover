FactoryGirl.define do
  factory :comment do
    body Faker::Name.name
    association :account, factory: :customer

    trait :by_admin do
      association :account, factory: :admin
    end

    trait :by_agent do
      association :account, factory: :agent
    end

    factory :agent_comment,   traits: [:by_agent]
    factory :admin_comment, traits: [:by_admin]
  end
end