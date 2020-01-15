class Route < ApplicationRecord
  belongs_to :truck, inverse_of: :routes
  belongs_to :truck_driver
  belongs_to :account
  has_many :dispatches, inverse_of: :route

  validates :account_id, presence: true
  scope :in_date, ->(date) { where(dispatch_date: date) }
  scope :open_in, ->(date) { where(dispatch_date: date.beginning_of_day..date.end_of_day).not_closed }
  scope :not_closed, -> { where(ended_at: nil) }
  scope :active, -> { where(active: true) }
end
