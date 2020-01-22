# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :account
  has_many :dispatch_guides
  has_many :contacts_addresses
  has_many :contacts, through: :contacts_addresses
  enum geocoding_status: {not_performed: 0, not_valid: 1, not_enabled: 2, error: 3, imprecise: 4, no_result: 5, model_error: 6, success: 7, processing: 8}
  scope :sort_by_name, ->(order) { order(name: order) }
end
