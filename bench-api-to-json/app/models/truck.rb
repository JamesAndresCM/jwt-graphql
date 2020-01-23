class Truck < ApplicationRecord
  enum vehicle_type: { truck: 0, pickup: 1, car: 2, motorcycle: 3, bicycle: 4, other: 5 }
  belongs_to :account
  has_one :truck_driver, dependent: :destroy
  has_many :routes, inverse_of: :truck, dependent: :delete_all
end

