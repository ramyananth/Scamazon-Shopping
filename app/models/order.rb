class Order < ApplicationRecord
    has_one :status
    belongs_to :user
  
    has_many :order_items,
    class_name: "OrderItem",
    primary_key: :id,
    foreign_key: :order_id
  
    has_many :items, through: :order_items
end