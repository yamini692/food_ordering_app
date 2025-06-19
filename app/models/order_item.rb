class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item
  scope :unbooked, -> {
  joins(:order).where(orders: { status: "placed" }, booked: [false, nil])
}

  scope :belonging_to_restaurant, ->(restaurant_id) {
  joins(:menu_item).where(menu_items: { user_id: restaurant_id })
}
end
