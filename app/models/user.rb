class User < ApplicationRecord
  has_many :borrowed_requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reactions, dependent: :destroy

  attr_accessor :remember_token

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

  enum role: {reader: 0, admin: 1}

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_column :remember_digest, nil
  end

  private

  def downcase_email
    email.downcase!
  end
end
