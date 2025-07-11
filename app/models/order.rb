class Order < ApplicationRecord
  validates :user_id, presence: true
  validates :payment_method, presence: true

  STATUSES = ['pending', 'placed', 'on the way', 'delivered', 'cancelled']
  validates :status, inclusion: { in: STATUSES }

  scope :not_deleted, -> { where(deleted_at: nil) }

  scope :unbooked_for_restaurant, ->(restaurant_id) {
    joins(:menu_item, :order_items)
      .where(
        menu_items: { user_id: restaurant_id },
        orders: { status: ["placed"]},
        order_items: { booked: [false, nil] }
      ).distinct
  }

  belongs_to :user
  belongs_to :menu_item
  has_many :order_items, dependent: :destroy
  has_one :review, dependent: :destroy

  def soft_delete
    update(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end
end
