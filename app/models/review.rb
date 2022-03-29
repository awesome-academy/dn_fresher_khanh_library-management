class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rating, numericality: {only_integer: true}

  validates :content,
            length: {maximum: Settings.validation.review.maximum_content_2000}
end
