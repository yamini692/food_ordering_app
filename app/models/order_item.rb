class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item
  scope :unbooked, -> { where(booked: [false, nil]) }
end

