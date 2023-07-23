# frozen_string_literal: true

FactoryBot.define do
  factory :activity do
    name { "MyString" }
    description { "MyText" }
    business { true }
  end
end
