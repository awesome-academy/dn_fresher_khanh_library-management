class BorrowedRequest < ApplicationRecord
  has_many :book_requests, dependent: :destroy

  belongs_to :user

  scope :order_status, ->{order :status, created_at: :desc}

  delegate :name, to: :user, prefix: true

  validates :status, numericality: {only_integer: true}
  enum status: {requested: 0, borrowing: 1, returned: 2, rejected: 3}

  def accept_request
    ActiveRecord::Base.transaction do
      borrowing!
      book_requests.each do |book_request|
        book_request.book.update! amount: decrease_amount(book_request)
      end
    end
  end

  def reject_request
    rejected!
  end

  def return_request
    ActiveRecord::Base.transaction do
      returned!
      book_requests.each do |book_request|
        book_request.book.update! amount: increase_amount(book_request)
      end
    end
  end

  private

  def increase_amount book_request
    book_request.book_amount + book_request.amount
  end

  def decrease_amount book_request
    book_request.book_amount - book_request.amount
  end
end
