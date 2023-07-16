# frozen_string_literal: true

# This model will store user information and handle authentication
class User < ApplicationRecord
  validates :email, presence: true
end
