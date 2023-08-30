# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    admin { false }

    after(:build) do |user|
      user.password = SecureRandom.hex(10)
    end
  end
end
