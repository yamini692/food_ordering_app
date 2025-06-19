class User < ApplicationRecord
  has_secure_password

  has_many :cart_items
  has_many :orders
  has_many :menu_items 
  has_many :reviews, dependent: :destroy

  before_validation :strip_email
  before_save :downcase_email

  def customer?
    role == "Customer"
  end

  def restaurant?
    role == "Restaurant"
  end

  private

  def strip_email
    self.email = email.strip if email.present?
  end


  def downcase_email
    self.email = email.downcase if email.present?
  end

end
