class Shop < ApplicationRecord
  belongs_to :user

  has_many_attached :photos

  validates :name, presence: true, uniqueness: true
  validates :owner_name, presence: true
  validates :hours_of_operation, presence: true
  validates :techs_per_shift, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :lounge_area, inclusion: { in: [true, false] }
  validates :supervisor_permanently, inclusion: { in: [true, false] }
  validates :complimentary_inspection, inclusion: { in: [true, false] }
  validates :vehicle_warranties, inclusion: { in: [true, false] }
  validates :location, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :categories, presence: true
  validates :languages, presence: true

  validates :certified, inclusion: { in: [true, false] }
  validates :tow_track, inclusion: { in: [true, false] }
  validates :vehicle_diesel, inclusion: { in: [true, false] }
  validates :vehicle_electric, inclusion: { in: [true, false] }
  validates :approved, inclusion: { in: [true, false] }
  validates :average_rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
