class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_length_of :phone_number, :minimum =>10, message: "is invalid. Make sure it is 10 digits"
  #validates_length_of :card_number, :minimum =>16, message: "should be 16 digits"
  validates :cvv, format: {with: /[0-9][0-9][0-9]/i, message: "should be 3 digits"}
  validates :expiry_date, format: {with: /0[1-9]|10|11|12\/2[0-9]/i, message: "should be in mm/yy format. Year has to be before 2020"}
  
  has_one :cart
  has_many :items, through: :cart

  def current_user_cart
    cart#{id}
  end 

  def add_to_cart(item_id)
    $redis.hincrby current_user_cart, item_id, 1
  end

  def remove_from_cart(item_id)
    $redis.hdel current_user_cart, item_id
  end

  def remove_one_from_cart(item_id)
    $redis.hincrby current_user_cart, item_id, -1
  end

  def cart_count
    quantities = $redis.hvals "cart#{id}"
    quantities.reduce(0) {|sum, qty| sum + qty.to_i}
  end

  def cart_total_price
    get_cart_items_with_qty.map {|item,qty|item.Cost * qty.to_i}.reduce(:+)
  end 

  def get_cart_items_with_qty
    cart_ids = []
    cart_qtys = []
    ($redis.hgetall current_user_cart).map do |key,value|
      cart_ids <<key 
      cart_qtys <<value
    end
    cart_items = Item.find(cart_ids)
    cart_items.zip(cart_qtys)
  end

  def purchase_cart_items!
    get_cart_items_with_qty.each do |item, qty|
      self.orders.create(user: self, item: item, quantity:qty)
    end
    $redis.del current_user_cart
  end
end
