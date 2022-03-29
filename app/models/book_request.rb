class BookRequest < ApplicationRecord
  belongs_to :book
  belongs_to :borrowed_request

  validates :status, numericality: {only_integer: true}
  enum status: {requested: 0, borrowing: 1, returned: 2, rejected: 3}

  validates :amount, numericality: {only_integer: true}
end
