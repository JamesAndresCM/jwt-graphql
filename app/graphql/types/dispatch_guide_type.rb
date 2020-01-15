# frozen_string_literal: true

module Types
  class DispatchGuideType < BaseObject
    field :id, ID, null: false
    field :account_id, ID, null: false, camelize: false
    field :code, String, null: false
    field :dispatches_count, Int, null: false, camelize: false
    field :place_id, Int, null: true, camelize: false
    field :first_estimated, DateTimeType, null: false, camelize: false
    field :service_time, Int, null: false, camelize: false
    field :min_delivery_time, DateTimeType, null: false, camelize: false
    field :max_delivery_time, DateTimeType, null: false, camelize: false
    field :beecode, String, null: true
    field :active, Boolean, null: true
    field :mode, String, null: true
    field :contact, Types::ContactType, null: false
    field :address, Types::AddressType, null: false
    field :dispatches, [Types::DispatchType], null: false
    field :custom_fields, [Types::CustomFieldType], null: false, camelize: false
  end
end
