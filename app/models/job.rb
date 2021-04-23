class Job < ApplicationRecord
  belongs_to :user
  has_one :claim

  geocoded_by :pick_up_address, latitude: :pick_up_latitude, longitude: :pick_up_longitude

  # after_validation :geocode

  validates_presence_of :title, :description, :pick_up_address, :drop_off_address, :pick_up_latitude, :pick_up_longitude, :drop_off_latitude,
                        :drop_off_longitude
end
