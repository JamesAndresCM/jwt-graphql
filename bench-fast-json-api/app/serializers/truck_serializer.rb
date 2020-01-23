class TruckSerializer
  include FastJsonapi::ObjectSerializer
  set_type :truck
  attributes :identifier
  has_one :truck_driver, serializer: :truck_driver
  has_many :routes, serializer: :route
end
