require 'json'

# this can be extended to add idempotency keys, logging, etc

class ApplicationService
  def self.call(params: {}, context: {}, **args)
    # instance = new(params: params, context: context)
    # if instance.recordable?
    # log_params
    # result = instance.call(**args)
    # log_result
    # result

    new(params: params, context: context).call(**args)
  end

  attr_reader :params, :context, :result
  # , :recordable?

  def initialize(params: {}, context: {})
    @params = params
    @context = context
    @result = Result.new
  end

  # these are equivalent to the delegate methods below, but aren't available without active_support
  def assign_data(value)
    result.assign_data(value)
  end

  def add_error(message)
    if message.is_a?(Array)
      message.each { |msg| result.add_error(msg) }
    else
      result.add_error(message)
    end
  end

  def success?
    result.success?
  end

  def failure?
    result.failure?
  end

  # delegate :assign_data, to: :result
  # delegate :add_error, to: :result
  # delegate :success?, to: :result
  # delegate :failure?, to: :result

  def step(method)
    return unless success?

    send(method)
  end

  def preload(*methods)
    methods.map { |method| send(method) }
  end

  def call
    raise NotImplementedError, 'You must implement the call method'
  end

  def safe_call(result)
    return result.data if result.success?

    add_error(result.errors)
  end

  # def call 
  #   transaction do
  #     step :validate
  #     step :create_order
  #     step :save_order
  #   end
  # end

  # this won't work without active record
  # def transaction
    
  #   ActiveRecord::Base.transaction do
  #     yield
  #     raise ActiveRecord::Rollback unless success?
  #   end

  # rescue ActiveRecord::Rollback => e
  #   # the errors will already be added to the result object on failure
  #   e.message
  # end

  def self.remote
    self
  end

  def self.call_async(params: {}, context: {})
    # this relies on sidekiq so for simplicity i have just called perform
    # AsyncWorker.perform_async(to_s, params.to_json, context.to_json)
    AsyncWorker.new.perform(to_s, params.to_json, context.to_json)
  end
end
