class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards, id: :uuid do |t|
      t.integer :cardNumber
      t.integer :ccv
      t.string :exp_date
      t.references :client, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
