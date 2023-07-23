# frozen_string_literal: true

# the model represents the employees of the company
class Employee < ApplicationRecord
  belongs_to :user, optional: true, inverse_of: :employees

  validates :name, presence: true
end
