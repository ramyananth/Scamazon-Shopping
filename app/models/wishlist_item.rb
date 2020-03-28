class WishlistItem < ApplicationRecord
  belongs_to :item,
  class_name: "Item",
  primary_key: :id,
  foreign_key: :item_id

  belongs_to :wishlist,
  class_name: "Wishlist",
  primary_key: :id,
  foreign_key: :wishlist_id


end
