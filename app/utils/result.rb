# frozen_string_literal: true

class Result
  attr_reader :value, :failure

  def self.success(value = nil)
    new.success!(value)
  end

  def self.failure(failure = nil)
    new.fail!(failure)
  end

  def initialize
    @value = nil
    @failure = nil
  end

  def success!(value)
    @value = value
    @failure = nil
    self
  end

  def fail!(failure)
    @value = nil
    @failure = failure
    self
  end

  def success?
    @failure.nil?
  end

  def failure?
    @failure.present?
  end
end
