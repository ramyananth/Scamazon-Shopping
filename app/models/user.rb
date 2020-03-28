class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  require 'redis'
  $redis = Redis.new(host: "localhost")
  # $redis = Redis.new
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  
  validates_length_of :phone_number, :minimum =>10, message: "is invalid. Make sure it is 10 digits"
  #validates_length_of :card_number, :minimum =>16, message: "should be 16 digits"
  validates :cvv, format: {with: /[0-9][0-9][0-9]/i, message: "should be 3 digits"}
  validates :expiry_date, format: {with: /0[1-9]|10|11|12\/2[0-9]/i, message: "should be in mm/yy format. Year has to be before 2020"}
  
  has_one :cart
  has_many :items, through: :cart

  has_one :wishlist
  has_many :items, through: :wishlist

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


  def current_user_wishlist
    wishlist#{id}
  end 

  def add_to_wishlist(item_id)
    $redis.hincrby current_user_wishlist, item_id, 1
  end

  def remove_from_wishlist(item_id)
    $redis.hdel current_user_wishlist, item_id
  end

  def remove_one_from_wishlist(item_id)
    $redis.hincrby current_user_wishlist, item_id, -1
  end

  def wishlist_count
    quantities = $redis.hvals "wishlist#{id}"
    quantities.reduce(0) {|sum, qty| sum + qty.to_i}
  end

  def wishlist_total_price
    get_wishlist_items_with_qty.map {|item,qty|item.Cost * qty.to_i}.reduce(:+)
  end 

  def get_wishlist_items_with_qty
    wishlist_ids = []
    wishlist_qtys = []
    ($redis.hgetall current_user_wishlist).map do |key,value|
      wishlist_ids <<key 
      wishlist_qtys <<value
    end
    wishlist_items = Item.find(wishlist_ids)
    wishlist_items.zip(wishlist_qtys)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
