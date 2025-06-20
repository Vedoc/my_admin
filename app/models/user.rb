class User < ApplicationRecord
  has_secure_password

  has_one :shop, dependent: :destroy
  has_many :devices, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
end
