class AddressSerializer
  include FastJsonapi::ObjectSerializer
  set_type :address
  attributes :name, :name_correct, :latitude, :longitude, :latitude_proposed, :longitude_proposed
end
