require_relative 'lib/result'
require_relative 'lib/store'
require_relative 'lib/user'
require_relative 'lib/order'
require_relative 'lib/application_service'
require_relative 'lib/async_worker'
require_relative 'lib/services/create_order'
require_relative 'lib/services/handle_order'

order_params = { item_name: 'item', quantity: 1 }
store_params = { name: 'store' }
user_params = { email: 'email_address' }

puts "no errors\n"
result = HandleOrder.remote.call(
  params: order_params, context: { store: store_params, user: user_params }
)

pp result
puts "\n"
# puts result.success? # => true
# puts result.data # => #<Order:0x00007f9b1c8b3d20 @item_name="item", @quantity=1>
# puts result.errors # => []

puts "nested errors\n"
result = HandleOrder.call(
  params: order_params.slice(:item_name), context: { store: store_params, user: user_params }
)

pp result
puts "\n"

puts "top level errors\n"
result = HandleOrder.call(
  params: order_params, context: { store: store_params, user: {} }
)

pp result
puts "\n"

# should you want the order to be handled asynchronously, you can call the following:

puts "async\n"
result = HandleOrder.call_async(
  params: order_params, context: { store: store_params, user: user_params }
)
pp result
puts "\n"
