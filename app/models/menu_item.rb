class MenuItem < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :available, inclusion: { in: [true, false] }
  validates :description, presence: true
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :unbooked_order_items, -> { unbooked }, class_name: "OrderItem"
  has_many :orders
  has_and_belongs_to_many :categories
end
