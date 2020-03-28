class Item < ApplicationRecord
  belongs_to :category,
  class_name: "Category", optional: true

  has_many :wishlist_items,
  class_name: "WishlistItem",
  primary_key: :id,
  foreign_key: :item_id

  has_many :cart_items,
  class_name: "CartItem",
  primary_key: :id,
  foreign_key: :item_id

  has_many :carts, through: :cart_items
  has_many :wishlists, through: :wishlist_items

  has_many :order_items,
  class_name: "OrderItem",
  primary_key: :id,
  foreign_key: :item_id

  has_many :orders, through: :order_items

  has_many :feedback

  # def self.search(search)
  #   if search
  #     find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  #   else
  #     find(:all)
  #   end
  # end

  # def self.filter(filter)
  #   if filter
  #     where(category_id: filter)
  #   end
  # end
  # scope :filter_by_brand, -> (brand) { where brand: brand }
  # scope :filter_by_category, -> (category_id) { where category_id: category_id }
  # scope :filter_by_availability, -> (quantity) { where("name like ?", "#{name}%")}
  has_many_attached :pictures

end
