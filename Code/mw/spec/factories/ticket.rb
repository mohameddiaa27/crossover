FactoryGirl.define do
  factory :ticket do
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraph
    association :customer, factory: :customer

    trait :invalid do
      title nil
    end

    trait :assigned do
      status 1
      association :agent, :random
    end

    trait :solved do
      status 2
      association :agent
    end

    factory :solved_ticket,   traits: [:solved]
    factory :assigned_ticket, traits: [:assigned]
  end
end
