# frozen_string_literal: true

module Types
  class PlaceType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :address, String, null: false
    field :latitude, Float, null: false
    field :longitude, Float, null: true
    field :is_deleted, Boolean, null: false, camelize: false
  end
end