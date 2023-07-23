# frozen_string_literal: true

# the model stores the actual working hours logged by employees
class Worklog < ApplicationRecord
  belongs_to :employee
  belongs_to :project
  belongs_to :activity

  validates :hours, numericality: {greater_than_or_equal_to: 0.0, less_than: 24.0}
end
