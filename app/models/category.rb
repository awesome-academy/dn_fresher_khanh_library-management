class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  has_many :subordinates, class_name: Category.name, foreign_key: :parent_id,
           dependent: :destroy

  belongs_to :parent, class_name: Category.name, optional: true

  validates :name, presence: true,
            length: {maximum: Settings.validation.category.maximum_name_50}
end
