# frozen_string_literal: true

module Types
  class TruckDriverAvailabilityType < BaseObject
    field :id, ID, null: false
    field :truck_driver_id, ID, null: false, camelize: false
    field :place_id, ID, null: false, camelize: false
    field :available, Boolean, null: true
    field :longitude, Float, null: true
    field :latitude, Float, null: true
    field :created_at, DateTimeType, null: false, camelize: false
  end
end
