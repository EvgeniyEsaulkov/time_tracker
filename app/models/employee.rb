# frozen_string_literal: true

# the model represents the employees of the company
class Employee < ApplicationRecord
  belongs_to :user, optional: true, inverse_of: :employees
  has_many :worklogs, dependent: :destroy

  validates :name, presence: true
end
