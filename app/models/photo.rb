class Photo < ApplicationRecord
  belongs_to :service_request
  validates :data, presence: true
end
