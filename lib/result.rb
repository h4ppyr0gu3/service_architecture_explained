# can be defined alongside the models
class Result
  attr_reader :data, :errors

  def initialize
    @data = nil
    @errors = []
  end

  def assign_data(value)
    @data = value
  end

  def add_error(message)
    @errors << message
  end

  def success?
    @errors.empty?
  end

  def failure?
    !success?
  end
end
