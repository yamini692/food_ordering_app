class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :quantity
  belongs_to :menu_item, serializer: MenuItemSerializer
end