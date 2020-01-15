# frozen_string_literal: true

class Contact < ApplicationRecord
  has_many :dispatch_guides
  belongs_to :account
  has_many :contacts_addresses
  has_many :addresses, through: :contacts_addresses

  validates :account_id, presence: true

  scope :sort_by_name, ->(order) { order(name: order) }
  scope :filter_by_name, lambda { |value|
    return all unless value.present?

    where(name: value)
  }
end
