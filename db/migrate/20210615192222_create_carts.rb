class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts, id: :uuid do |t|
      t.references :client, null: false, type: :uuid
      t.string :products
      t.integer :status

      t.timestamps
    end
  end
end
