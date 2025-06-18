# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  has_many :cart_items
  has_many :orders
  has_many :menu_items 
  has_many :reviews, dependent: :destroy

  def customer?
    role == "Customer"
  end

  def restaurant?
    role == "Restaurant"
  end
end
