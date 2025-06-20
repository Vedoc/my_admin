class Vehicle < ApplicationRecord
  belongs_to :clients
  has_one_attached :photo
  has_many :service_requests
  validates :category, :model, :make, :year, presence: true

  def as_json(options = {})
    super(options).merge(
      photo: photo.url
    )
  end
end
