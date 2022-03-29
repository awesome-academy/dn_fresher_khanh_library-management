class User < ApplicationRecord
  has_many :borrowed_requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reactions, dependent: :destroy

  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.validation.user.maximum_name_50}

  validates :email, presence: true,
            length: {maximum: Settings.validation.user.maximum_email_255},
            format: {with: Settings.validation.user.valid_email_regex},
            uniqueness: true

  has_secure_password
  validates :password, presence: true,
            length: {minimum: Settings.validation.user.minimum_password_6},
            allow_nil: true

  private

  def downcase_email
    email.downcase!
  end
end
