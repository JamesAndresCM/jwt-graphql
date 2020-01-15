# frozen_string_literal: true

module Types
  class RouteType < BaseObject
    field :id, ID, null: false
    field :active, Boolean, null: true
    field :dispatch_date, String, null: false, camelize: false
    field :start_time, String, null: false, camelize: false
    field :end_time, String, null: false, camelize: false
    field :created_at, DateTimeType, null: false, camelize: false
    field :dispatches, [Types::DispatchType], null: false
  end
end