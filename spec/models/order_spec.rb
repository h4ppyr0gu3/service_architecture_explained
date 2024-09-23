require 'rspec'
require_relative '../../lib/order'

RSpec.describe Order do
  it 'creates a valid order', :aggregate_failures do
    order = Order.new(item_name: 'item', quantity: 1, store: 'store', user: 'user')
    expect(order.item_name).to eq 'not item'
    expect(order.quantity).to eq 1
    expect(order.user).to eq 'sth'
    puts 'final expectation checked?'
    expect(order.store).to eq 'store'
  end
end
