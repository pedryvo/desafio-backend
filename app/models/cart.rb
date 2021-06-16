class Cart < ApplicationRecord
  enum status: [ :open, :closed ]
  after_create :initialize_bucket
  belongs_to :client

  def insert_product(product_id)
    if self.products == ''
      self.update!(products: self.products.insert(0, product_id))
    else
      self.update!(products: self.products.insert(-1, ",#{product_id}"))
    end
  end

  def total_price
    products = self.products.split(',')
    products.map! {|p| Product.find(p.to_s).price}
    products.inject(:+)
  end

  private

  def initialize_bucket
    self.update!(products: '')
  end
end
