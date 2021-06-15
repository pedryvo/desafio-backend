FactoryBot.define do
  factory :client do
    name { Faker::Fantasy::Tolkien.character }
  end
end
