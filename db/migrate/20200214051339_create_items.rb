class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :Unique_ID, null: false
      t.string :Brand, null: false
      t.string :Name, null: false
      t.string :Category, null: false
      t.boolean :Restricted_item, null: false
      t.boolean :Age_restricted_item, null: false
      t.boolean :Availability, null: false
      t.float :Popularity
      t.integer :Quantity, null: false
      t.float :Cost, null: false
      t.string :Tax_Slab, null: false
      t.integer :photo
      
      t.timestamps
    end
  end
end
