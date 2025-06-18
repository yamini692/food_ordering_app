class MenuItem < ApplicationRecord
  belongs_to :restaurant, class_name: "User", foreign_key: "user_id"
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
end
