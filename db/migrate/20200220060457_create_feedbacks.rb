class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.string :name, null: false
      t.references :item, null: false
      t.text :comment, null: false
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
