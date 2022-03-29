class Publisher < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true,
            length: {maximum: Settings.validation.publisher.maximum_name_50}
end
