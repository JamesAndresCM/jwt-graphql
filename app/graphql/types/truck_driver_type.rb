# frozen_string_literal: true

module Types
  class TruckDriverType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :username, String, null: false
    field :telephone, String, null: true
    field :pin_code, String, null: false, camelize: false
    field :unique_hash, Boolean, null: true, camelize: false
    field :active, Boolean, null: true
    field :app_version, String, null: true, camelize: false
    field :device_name, String, null: false, camelize: false
    field :os_version, String, null: true, camelize: false
    field :picture_approved, Boolean, null: true, camelize: false
    field :picture, String, null: true
    field :created_at, DateTimeType, null: false, camelize: false
    field :truck, Types::TruckType, null: false
    field :routes, [Types::RouteType], null: true
    field :truck_driver_availabilities, [Types::TruckDriverAvailabilityType], null: true, camelize: false
  end
end
