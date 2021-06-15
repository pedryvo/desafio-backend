Rails.application.routes.draw do
  scope :starstore do
    get '/products', to: 'products#index'
    post '/product', to: 'products#create'
  end
end
