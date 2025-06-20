class Device < ApplicationRecord
  belongs_to :user

  validates :platform, presence: true
  validates :device_id, presence: true, uniqueness: true
  validates :device_token, presence: true
end
