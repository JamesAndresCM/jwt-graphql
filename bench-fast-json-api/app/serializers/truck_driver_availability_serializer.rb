class TruckDriverAvailabilitySerializer
  include FastJsonapi::ObjectSerializer
  set_type :truck_driver_availability
  attributes :available, :truck_driver_id

  attribute :created_at do |object|
    object.created_at.present? ? object.created_at.iso8601 : nil
  end
end
