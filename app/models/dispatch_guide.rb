class DispatchGuide < ApplicationRecord
  belongs_to :account, inverse_of: :dispatch_guides
  belongs_to :place
  belongs_to :contact, optional: true
  belongs_to :address, optional: true
  has_many :dispatches, foreign_key: 'guide_id', inverse_of: :guide
  enum mode: { default: 0, pickup_only: 1, pickup_and_delivery: 2, pickup_and_drop: 3 }
  belongs_to :pickup_address, foreign_key: :pickup_address_id, class_name: 'Address', optional: true
  has_many :custom_fields, as: :model, dependent: :destroy
  has_many :custom_field_types, through: :custom_fields
  validates :code, presence: true
  validates :account_id, presence: true
end
