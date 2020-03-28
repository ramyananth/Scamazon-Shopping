class CreateTaxes < ActiveRecord::Migration[6.0]
  def change
    create_table :taxes do |t|
      t.float :Tax_Slab

      t.timestamps
    end
  end
end
