require_relative './create_order'
require 'pry'

class HandleOrder < ApplicationService
  def call
    preload :user, :store

    step :validate
    step :create_order

    result
  end

  private

  def validate
    return add_error('Invalid email') if user.email.nil?

    add_error('Invalid store') if store.name.nil?
  end

  def create_order
    order = safe_call(
      ::CreateOrder.call(params: {
                           item_name: params[:item_name],
                           quantity: params[:quantity]
                         }, context: { user: user, store: store })
    )

    assign_data(order)
  end

  def store
    @store ||= Store.new(name: context[:store][:name])
  end

  def user
    @user ||= User.new(email: context[:user][:email])
  end
end
