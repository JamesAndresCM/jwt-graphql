class TruckDriver < ApplicationRecord
  belongs_to :truck
  belongs_to :account
  has_many :routes, dependent: :destroy
  has_many :truck_driver_availabilities, dependent: :destroy
end
