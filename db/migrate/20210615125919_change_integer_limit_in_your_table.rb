class ChangeIntegerLimitInYourTable < ActiveRecord::Migration[6.1]
  def change
    change_column :cards, :cardNumber, :integer, limit: 8
  end
end
