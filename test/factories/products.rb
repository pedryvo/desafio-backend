FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    price { SecureRandom.random_number(10**3).to_s.rjust(3, '0') }
    zipcode { SecureRandom.random_number(10**7).to_s.rjust(7, '0') }
    client_id { Client.all.sample.id }
    thumbnailHd { Faker::Avatar.image }
  end
end
