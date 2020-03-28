class Cart < ApplicationRecord
  validates :user_id, presence: true
  validates :admin_id, presence: true
  belongs_to :user

  has_many :cart_items,
  class_name: "CartItem",
  primary_key: :id,
  foreign_key: :cart_id

  has_many :items, through: :cart_items
end
