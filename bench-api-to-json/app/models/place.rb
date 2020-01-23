class Place < ApplicationRecord
  belongs_to :account
  has_many :dispatch_guides
  validates :account_id, presence: true
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
