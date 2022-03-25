class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.const.maximum_name_length_50}

  validates :email, presence: true,
            length: {maximum: Settings.const.maximum_email_length_255},
            format: {with: Settings.const.valid_email_regex},
            uniqueness: true

  has_secure_password
  validates :password, presence: true,
            length: {minimum: Settings.const.minimum_password_length_6},
            allow_nil: true

  private

  def downcase_email
    email.downcase!
  end
end
