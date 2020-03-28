class AddNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :phone_number, :string
    add_column :users, :address, :string
    add_column :users, :name_on_card, :string
    add_column :users, :card_number, :string
    add_column :users, :expiry_date, :string
    add_column :users, :cvv, :string

    add_column :admins, :name, :string
    add_column :admins, :date_of_birth, :date
    add_column :admins, :phone_number, :string
    add_column :admins, :address, :string
    add_column :admins, :name_on_card, :string
    add_column :admins, :card_number, :string
    add_column :admins, :expiry_date, :string
    add_column :admins, :cvv, :string

  end
end

