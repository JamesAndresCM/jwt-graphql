class Account < ApplicationRecord
  has_many :users, inverse_of: :account
  has_many :trucks
  has_many :routes
  has_many :truck_drivers
  has_many :places
  has_many :contacts
  has_many :addresses
  has_many :dispatches, inverse_of: :account
  has_many :dispatch_guides, inverse_of: :account
end
