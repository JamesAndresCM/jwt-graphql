# frozen_string_literal: true

module Types
  class CustomFieldTypeType < BaseObject
    field :id, ID, null: false
    field :account_id, ID, null: false, camelize: false
    field :name, String, null: false
    field :model_type, Int, null: true, camelize: false
    field :show_in_web, Boolean, null: true, camelize: false
    field :show_in_mobile, Boolean, null: true, camelize: false
    field :has_many_flag, Boolean, null: true, camelize: false
    field :created_at, DateTimeType, null: false, camelize: false
    field :account, Types::AccountType, null: false
  end
end
