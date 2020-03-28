# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Payment.delete_all
User.delete_all
CartItem.delete_all
Cart.delete_all
Category.delete_all
ItemCategory.delete_all
Item.delete_all
Admin.delete_all

Admin.create(email: "admin@gmail.com", password: "admin5", name: "Admin", date_of_birth: "1996-01-01", phone_number: "9199199190", address: "123456 Raleigh", name_on_card: "Admin Csc 517", expiry_date: "04/24", card_number: "1234567890111213", cvv: "123")

status1 = Status.create(status: "Received")
status2 = Status.create(status: "Pending")
status3 = Status.create(status: "Unshipped")
status4 = Status.create(status: "Shipped")
status5 = Status.create(status: "Delivered")
status6 = Status.create(status: "Canceled")

apparels = Category.create(title: "Apparels")
computers = Category.create(title: "Computers")
electronics = Category.create(title: "Electronics")

# user1 = User.create(name: "Michael Scott", email: "mscott@gmail.com", password: "password", phone_number: "9190000919", date_of_birth: "1996-01-01", address: "No. 123 Avent Ferry Road, Raleigh, NC 27606", cart_id: "1", wishlist_id: "1", payment_id: "1")
# payment1 = Payment.create(name: "Michael Scott", card_number: "1234567890123456", expiry_date: "2025-05-30", cvv: "987", user_id: "1")
# user1.payment_id = payment1.id
# user1.save

# Tax table data
tax1 = Tax.create(Tax_Slab: 10.00)
tax2 = Tax.create(Tax_Slab: 20.00)
tax3 = Tax.create(Tax_Slab: 30.00)

# Items data 
item1 = Item.create!(Unique_ID: "ChampT", Brand: "Champion", Name: "MensTshirt", Category: apparels.title.to_s, Restricted_item: false, Age_restricted_item: false, Availability: true, Quantity: 5, Cost: 26.23, Tax_Slab: tax1.id)
item1.save!

item2 = Item.create(Unique_ID: "LenIdea", Brand: "Lenovo", Name: "LenovoIdeapad", Category: computers.title, Restricted_item: true, Age_restricted_item: false, Availability: true, Quantity: 2, Cost: 724.83, Tax_Slab: tax2.id)
item2.save!

item3 = Item.create(Unique_ID: "HelicDJ", Brand: "TC-Helicon", Name: "GoXLR", Category: electronics.title, Restricted_item: false, Age_restricted_item: true, Availability: false, Quantity: 0, Cost: 481.75, Tax_Slab: tax3.id)
item3.save!

item4 = Item.create(Unique_ID: "UmBreL", Brand: "Tiscon", Name: "Umbrella", Category: apparels.title, Restricted_item: false, Age_restricted_item: false, Availability: true, Quantity: 5, Cost: 10.21, Tax_Slab: tax1.id)
item4.save!
# cart1 = Cart.create(user_id: user1.id)
# user1.cart_id = cart1.id
# user1.save!

# CartItem.create(cart_id: cart1.id, item_id: item1.id)
# CartItem.create(cart_id: cart1.id, item_id: item2.id)

# wishlist1 = Wishlist.create(user_id: user1.id)
# user1.cart_id = cart1.id
# user1.save!

# WishlistItem.create(user_id: user1.id, item_id: item3.id)

# feedback1 = Feedback.create(name: "Sam", item_id: item2.id, comment: "Unboxed earlier today and about 3 hours into use the backlight suddenly went out and unable to turn back on. Went through all the typical fixes such as restarting, adjusting brightness, adjust refresh rate, replace battery. Props to Lenovo for making me pay for shipping to repair my three hour old laptop. Guess i'll stay clear away from Lenovo products moving forward." )

# order1 = Order.create(user_id: user1.id, status_id: status1.id.to_i)

# CART
Cart.destroy_all
puts "\nTotal cart count: #{Cart.all.count}"
