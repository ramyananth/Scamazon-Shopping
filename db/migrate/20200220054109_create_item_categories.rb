class CreateItemCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :item_categories do |t|
      t.integer :item_id, null: false
      t.integer :category_id, null: false

      t.timestamps
    end
  end
end
