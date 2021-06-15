Rails.application.routes.draw do
  scope :starstore do
    get '/products', to: 'products#index'
    post '/product', to: 'products#create'
    post '/cart', to: 'purchase#shopping_cart'
    get '/history', to: 'purchase#closed_carts'
    post '/buy', to: 'purchase#buy'
  end
end
