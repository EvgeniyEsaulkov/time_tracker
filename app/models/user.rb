# frozen_string_literal: true

# This model will store user information and handle authentication
class User < ApplicationRecord
  has_many :employees, dependent: :nullify

  validates :email, presence: true
end
