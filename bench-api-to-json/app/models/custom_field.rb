# frozen_string_literal: true

class CustomField < ApplicationRecord
  belongs_to :account
  belongs_to :model, polymorphic: true
  belongs_to :custom_field_type

  scope :sort_by_value, ->(order) { order(value: order) }
  scope :filter_by_value, lambda{|value|
    return all unless value.present?

    strip_value = value.strip.gsub(/\s+/, ' ')
    where(value: strip_value)
  }
  scope :sort_by_value_same_type, lambda{|preferent, order|
    where(custom_field_type_id: preferent).order(value: order)
  }
end
