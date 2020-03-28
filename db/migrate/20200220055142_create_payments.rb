class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :name, null: false
      t.string :card_number, null: false
      t.date :expiry_date, null: false
      t.string :cvv, null: false
      t.string :user_id, null: false

      t.timestamps
    end
  end
end
