class Video < ApplicationRecord
  belongs_to :service_request
  validates :data, presence: true
end
