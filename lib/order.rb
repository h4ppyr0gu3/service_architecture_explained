class Order
  attr_accessor :item_name, :quantity, :store, :user

  def initialize(item_name:, quantity:, store:, user:)
    @item_name = item_name
    @quantity = quantity
    @store = store
    @user = user
  end
end
