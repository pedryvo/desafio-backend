FactoryBot.define do
  factory :card do
    client
    cardNumber { Faker::CreditCard.visa }
    ccv { SecureRandom.random_number(10**3).to_s.rjust(3, '0') }
    exp_date { DateTime.now.next_year(2).to_time.strftime("%m/%y") }
  end
end
