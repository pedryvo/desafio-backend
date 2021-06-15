class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :title
      t.integer :price
      t.string :zipcode
      t.references :client, null: false, foreign_key: true, type: :uuid
      t.string :thumbnailHd

      t.timestamps
    end
  end
end
