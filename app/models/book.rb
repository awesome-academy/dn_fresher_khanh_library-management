class Book < ApplicationRecord
  has_many :book_requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reactions, dependent: :destroy

  belongs_to :author
  belongs_to :category
  belongs_to :publisher

  has_one_attached :image

  validates :name, presence: true,
            length: {maximum: Settings.validation.book.maximum_name_100}

  validates :detail,
            length: {maximum: Settings.validation.book.maximum_detail_2000}

  validates :amount, numericality: {only_integer: true}

  validates :image, content_type: {
    in: Settings.validation.book.image_content_type,
    message: Settings.validation.book.image_content_type_message
  },
            size: {less_than: Settings.validation.book.image_size,
                   message: Settings.validation.book.image_size_message}
end
