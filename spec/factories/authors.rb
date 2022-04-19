FactoryBot.define do
  factory :author do
    name {Faker::Book.author}
    detail {Faker::ChuckNorris.fact}
  end
end
