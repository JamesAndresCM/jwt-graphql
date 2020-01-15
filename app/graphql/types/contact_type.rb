# frozen_string_literal: true

module Types
  class ContactType < BaseObject
    field :id, ID, null: false
    field :account_id, ID, null: false, camelize: false
    field :email, String, null: true
    field :phone, String, null: true
    field :identifier, String, null: true
    field :name, String, null: true
    field :contact_type, Int, null: true, camelize: false
    field :created_at_at, DateTimeType, null: false, camelize: false
    field :last_sent_survey, DateTimeType, null: true, camelize: false
    field :guides, [Types::DispatchGuideType], null: false
    field :account, Types::AccountType, null: false
  end
end
