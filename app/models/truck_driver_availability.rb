class TruckDriverAvailability < ApplicationRecord
  belongs_to :truck_driver
  belongs_to :place
end
