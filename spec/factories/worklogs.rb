# frozen_string_literal: true

FactoryBot.define do
  factory :worklog do
    employee
    project
    activity
    work_date { "2023-07-23" }
    hours { 7.5 }
  end
end
