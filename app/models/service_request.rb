class ServiceRequest < ApplicationRecord
  belongs_to :vehicle

  has_many :photos, class_name: 'Photo', dependent: :destroy
  has_many :videos, class_name: 'Video', dependent: :destroy

  accepts_nested_attributes_for :photos
  accepts_nested_attributes_for :videos

  def parsed_location
    if location.present? && location.respond_to?(:latitude) && location.respond_to?(:longitude)
      { lat: location.latitude, long: location.longitude }
    elsif location.is_a?(String)
      match_data = location.match(/POINT \((\S+) (\S+)\)/)
      if match_data
        longitude = match_data[1].to_f
        latitude = match_data[2].to_f
        { lat: latitude, long: longitude }
      else
        nil
      end
    else
      nil
    end
  end
end
