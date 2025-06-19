class MenuItem < ApplicationRecord
  belongs_to :restaurant, class_name: "User", foreign_key: "user_id"
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :unbooked_order_items, -> { unbooked }, class_name: "OrderItem"
end
