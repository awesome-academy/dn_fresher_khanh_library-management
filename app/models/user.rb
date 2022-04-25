class User < ApplicationRecord
  has_many :borrowed_requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reactions, dependent: :destroy

  devise :database_authenticatable, :registerable, :rememberable, :validatable

  attr_accessor :remember_token

  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.validation.user.maximum_name_50}

  validates :email, presence: true,
            length: {maximum: Settings.validation.user.maximum_email_255},
            format: {with: Settings.validation.user.valid_email_regex},
            uniqueness: true

  enum role: {reader: 0, admin: 1}

  private

  def downcase_email
    email.downcase!
  end
end
