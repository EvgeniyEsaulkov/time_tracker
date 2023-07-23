# frozen_string_literal: true

# this model defines the different types of activities that employees can log
class Activity < ApplicationRecord
  validates :name, presence: true

  attribute :business, default: true
end
