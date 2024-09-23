class CreateOrder < ApplicationService
  def call
    step :validate
    step :create_order

    result
  end

  private

  def validate
    return add_error('Invalid item name') if params[:item_name].nil?
    return add_error('Invalid quantity') if params[:quantity].nil?
  end

  def create_order
    order = Order.new(
      item_name: params[:item_name],
      quantity: params[:quantity],
      store: context[:store],
      user: context[:user]
    )

    assign_data(order)
  end
end
