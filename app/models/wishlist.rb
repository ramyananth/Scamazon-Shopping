class Wishlist < ApplicationRecord
  # validates :user_id, presence: true

  belongs_to :user
  belongs_to :admin

  has_many :wishlist_items,
  class_name: "WishlistItem",
  primary_key: :id,
  foreign_key: :wishlist_item_id

  has_many :items, through: :wishlist_items

end
