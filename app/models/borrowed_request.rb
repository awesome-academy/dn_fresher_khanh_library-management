class BorrowedRequest < ApplicationRecord
  has_many :book_requests, dependent: :destroy

  belongs_to :user

  scope :order_status, ->{order :status, created_at: :desc}

  delegate :name, to: :user, prefix: true

  validates :status, numericality: {only_integer: true}
  enum status: {requested: 0, borrowing: 1, returned: 2, rejected: 3}
end
