class PickupAddressSerializer
  include FastJsonapi::ObjectSerializer
  set_type :pickup_address
  attributes :name, :name_correct, :latitude, :longitude, :latitude_proposed, :longitude_proposed
end
