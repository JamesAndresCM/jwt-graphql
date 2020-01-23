class TruckDriverSerializer
  include FastJsonapi::ObjectSerializer
  set_type :truck_driver
  attributes :name, :telephone
  belongs_to :truck, serializer: TruckSerializer
  has_many :truck_driver_availabilities
end
