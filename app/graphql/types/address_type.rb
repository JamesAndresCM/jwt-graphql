# frozen_string_literal: true

module Types
  class AddressType < BaseObject
    field :id, ID, null: false
    field :account_id, ID, null: false, camelize: false
    field :name, String, null: false
    field :name_correct, String, null: true, camelize: false
    field :city, String, null: true
    field :country, String, null: true
    field :state, String, null: true
    field :postal_code, String, null: true, camelize: false
    field :latitude, Float, null: true
    field :latitude_proposed, Float, null: true, camelize: false
    field :longitude, Float, null: true
    field :longitude_proposed, Float, null: true, camelize: false
    field :geocoding_status, String, null: true, camelize: false
    field :dispatch_guides, [Types::DispatchGuideType], null: true
    field :account, Types::AccountType, null: false
  end
end
