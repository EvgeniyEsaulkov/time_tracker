# frozen_string_literal: true

require "capybara/cuprite"

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
end

Capybara.configure do |config|
  config.default_driver = :cuprite
  config.javascript_driver = :cuprite
  config.default_max_wait_time = 5
  config.exact = true
  config.match = :smart
  config.ignore_hidden_elements = true
end
