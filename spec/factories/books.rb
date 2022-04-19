FactoryBot.define do
  factory :book do
    name {Faker::Book.title}
    detail {Faker::Books::Dune.quote}
    amount {2}
  end
end
