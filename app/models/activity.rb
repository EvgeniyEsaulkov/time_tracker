# frozen_string_literal: true

# this model defines the different types of activities that employees can log
class Activity < ApplicationRecord
  has_many :worklogs, dependent: :destroy

  validates :name, presence: true

  attribute :business, default: true
end
