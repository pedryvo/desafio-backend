FactoryBot.define do
  factory :cart do
    client { nil }
    products { "MyString" }
    status { 1 }
  end
end
