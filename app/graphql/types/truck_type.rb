# frozen_string_literal: true

module Types
  class TruckType < BaseObject
    field :id, ID, null: false
    field :identifier, String, null: false
    field :is_ramp, Boolean, null: true, camelize: false
    field :active, Boolean, null: true
    field :has_own_gps, Boolean, null: true, camelize: false
    field :vehicle_type, String, null: false, camelize: false
    field :capacity, Float, null: true
    field :account, Types::AccountType, null: false
    field :truck_driver, Types::TruckDriverType, null: true, camelize: false
    field :routes, [Types::RouteType], null: true
  end
end
