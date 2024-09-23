require 'json'

class AsyncWorker
  # include Sidekiq::Worker
  # sidekiq_options retry: false

  def perform(worker_class, params, context)
    # these methods would be available with active support
    worker_params = deep_symbolize_keys(JSON.parse(params))
    worker_context = deep_symbolize_keys(JSON.parse(context))

    # constantize is active support method
    # worker_class.constantize.call(params: JSON.parse(params), context: JSON.parse(context))

    klass = Object.const_get(worker_class)

    klass.call(params: worker_params, context: worker_context)
  end

  def deep_symbolize_keys(hash)
    hash.each_with_object({}) do |(key, value), result|
      result[key.to_sym] = value.is_a?(Hash) ? deep_symbolize_keys(value) : value
    end
  end
end
