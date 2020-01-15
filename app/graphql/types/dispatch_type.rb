# frozen_string_literal: true

module Types
  class DispatchType < BaseObject
    field :id, ID, null: false
    field :account_id, ID, null: false, camelize: false
    field :guide_id, ID, null: false, camelize: false
    field :route_id, ID, null: false, camelize: false
    field :status_id, Int, null: true, camelize: false
    field :estimated_at, DateTimeType, null: false, camelize: false
    field :arrived_at, DateTimeType, null: false, camelize: false
    field :slot, Int, null: true
    field :has_form, Boolean, null: true, camelize: false
    field :is_trunk, Boolean, null: true, camelize: false
    field :guide, Types::DispatchGuideType, null: false
    field :route, Types::RouteType, null: false
    field :contact, Types::ContactType, null: false
  end
end
