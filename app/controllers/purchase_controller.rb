class PurchaseController < ApplicationController

  def shopping_cart
    params.permit!
    unless params.include?('client_id') && params.include?('product_id')
      render json: {'message': 'Invalid payload.'}, status: :bad_request
    else
      client = Client.find(params['client_id'])

      if Product.where(id: params['product_id']).empty?
        render json: {'message': "Product doesn't exist."}, status: :bad_request
      elsif client.carts.where(status: :open).empty?
        cart = Cart.create!(client_id: client.id, status: :open)
        cart.insert_product(params['product_id'])
        render json: {'message': 'Cart created and product added.'}, status: :created
      elsif client.carts.where(status: :open).first.products.include? params['product_id'] # check if cart already has the product
        render json: {'message': 'Product was already added to shopping cart.'}, status: :unauthorized
      else
        client.carts.where(status: :open).first.insert_product(params['product_id'])
        render json: {'message': 'Product added to shopping cart.'}, status: :ok
      end
    end
  end

  def buy
    params.permit!
    unless checkout_data.include? 'Invalid'
      Client.find(params[:client_id]).carts.where(status: :open).first.update!(status: :closed)
      render json: {'message'=> 'Successful purchase.'}, status: :ok
    else
      render json: checkout_data, status: :bad_request
    end
  end

  def closed_carts
    @closed_carts = Cart.all.where(status: :closed)
    render json: @closed_carts, status: :ok
  end

  private

  def checkout_data
    client_exists = Client.where(id: params[:client_id]).exists?

    has_keys =  %i[ client_id credit_card total_to_pay client_name ].all? {|s| params.key? s} && 
                %i[ card_number value cvv card_holder_name exp_date ].all? {|s| params[:credit_card].key? s}

    is_client_data_correct = Client.find(params[:client_id]).name == params[:client_name] if client_exists

    is_card_data_correct =  Client.find(params[:client_id]).card.cardNumber == params[:credit_card][:card_number] &&
                            Client.find(params[:client_id]).card.ccv == params[:credit_card][:ccv] &&
                            Client.find(params[:client_id]).card.exp_date == params[:credit_card][:exp_date] &&
                            Client.find(params[:client_id]).name == params[:credit_card][:card_holder_name] if client_exists

    is_total_correct = Client.find(params[:client_id]).carts.where(status: :open).first.total_price == params[:credit_card][:value] if client_exists

    if has_keys && is_client_data_correct && is_card_data_correct && is_total_correct
      params
    else
      {'message' => 'Invalid payload.'}
    end
  end
end
