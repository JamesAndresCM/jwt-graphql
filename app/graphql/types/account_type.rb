# frozen_string_literal: true

module Types
  class AccountType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :type, String, null: false
    field :email, String, null: true
    field :api_key, String, null: true, camelize: false
    field :chat_enabled, Boolean, null: true
    field :language, String, null: true
    field :country, String, null: true
    field :active, Boolean, null: true
    field :has_ondemand, Boolean, null: true, camelize: false
    field :trucks, [Types::TruckType], null: false
    field :contacts, [Types::ContactType], null: false
    field :addresses, [Types::AddressType], null: false
    field :places, [Types::PlaceType], null: false
    field :dispatches, [Types::DispatchType], null: false
    field :truck_drivers, [Types::TruckDriverType], null: false, camelize: false

    def truck_drivers
      object.truck_drivers.eager_load(
        :truck_driver_availabilities,
        truck:
        {
          routes: {
            dispatches: {
              guide: %i[contact address custom_fields custom_field_types]
            }
          }
        }
      )
    end
  end
end
