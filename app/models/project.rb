# frozen_string_literal: true

# This model represents the different projects within the company.
# Each employee's working hours are associated with a specific project
class Project < ApplicationRecord
  validates :name, presence: true

  has_rich_text :description
end
