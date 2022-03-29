class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true,
            length: {maximum: Settings.validation.author.maximum_name_50}

  validates :detail,
            length: {maximum: Settings.validation.author.maximum_detail_2000}

  validates :image, content_type: {
    in: Settings.validation.author.image_content_type,
    message: Settings.validation.author.image_content_type_message
  },
            size: {less_than: Settings.validation.author.image_size,
                   message: Settings.validation.author.image_size_message}
end
