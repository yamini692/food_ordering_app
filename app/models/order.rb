class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items ,dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
end
