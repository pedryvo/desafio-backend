class Client < ApplicationRecord
  has_one :card
  has_many :purchases
  has_many :carts
end
