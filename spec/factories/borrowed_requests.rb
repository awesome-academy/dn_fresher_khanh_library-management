FactoryBot.define do
  factory :borrowed_request do
    status {0}
    borrowed_date {Time.new(2022, 4, 20)}
    returned_date {Time.new(2022, 4, 22)}
  end
end
