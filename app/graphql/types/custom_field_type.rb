# frozen_string_literal: true

module Types
  class CustomFieldType < BaseObject
    field :id, ID, null: false
    field :custom_field_type_id, ID, null: false, camelize: false
    field :model_id, ID, null: false, camelize: false
    field :model_type, String, null: false, camelize: false
    field :value, String, null: true
    field :created_at, DateTimeType, null: false, camelize: false
    field :custom_field_type, Types::CustomFieldTypeType, null: false, camelize: false
  end
end
