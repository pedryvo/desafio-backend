class ProductsController < ApplicationController
  def index
    @products = Product.all
    render json: @products, status: :ok
  end

  def create
    hash = product_params.to_h
    binding.pry
    hash['created_at'] = DateTime.parse hash['date']
    hash.delete 'date'
    hash['client_id'] = Client.find_by(name: hash['seller']).id
    hash.delete 'seller'

    @product = Product.create(hash)
    if @product.valid?
      render json: @product, status: :ok
    else
      render json: @product.errors.full_messages, status: :internal_server_error
    end
  end

  private

  def product_params
    params.permit(:title, :price, :zipcode, :seller, :thumbnailHd, :date)
  end 
end
