class Dispatch < ApplicationRecord
  belongs_to :account, inverse_of: :dispatches
  belongs_to :guide, -> { where(active: true) }, class_name: 'DispatchGuide', inverse_of: :dispatches, touch: true
  belongs_to :route, inverse_of: :dispatches
  enum priority: { regular: 0, low: -1, high: 1, very_high: 2 }

  validates :guide_id, presence: true
  STATUS_CLASS_NAMES = {1 => 'pending', 2 => 'success', 3 => 'danger', 4 => 'warning'}.freeze
  STATUSES = { pending: 1, delivered: 2, not_delivered: 3, partial: 4 }.freeze

  default_scope { where(is_deleted: false) }
  scope :managed, -> { where.not(status_id: STATUSES[:pending]) }
  scope :not_managed, -> { where(status_id: STATUSES[:pending]) }

  scope :pending, -> { where(status_id: STATUSES[:pending_id]) }
  scope :arrived, -> { where.not(status_id: STATUSES[:pending_id]).order(arrived_at: :ASC) }
  # will order first by arrived_at (which shows the real used order), putting NULLs at last
  # then by slot (this will be applied to duplicated arrived_at date and also to NULL dates).
  # Please note that "ISNULL(arrived_at) ASC, arrived_at ASC" can be achieved
  # in MySQL using undocumented syntax to sort null: "-arrived_at DESC"
  # or in some others DBMS using sql 2003 standard "arrived at ASC NULLS LAST"
  scope :ordered, -> { order(Arel.sql('ISNULL(arrived_at) ASC, arrived_at ASC, slot ASC')) }
  scope :last_mile, -> { where(is_trunk: false) }

  def service_time
    (guide.service_time || 0).minutes
  end
end
