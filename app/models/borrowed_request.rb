class BorrowedRequest < ApplicationRecord
  has_many :book_requests, dependent: :destroy

  belongs_to :user

  validates :status, numericality: {only_integer: true}
  enum status: {requested: 0, borrowing: 1, returned: 2, rejected: 3}
end
