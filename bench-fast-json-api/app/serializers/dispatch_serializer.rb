class DispatchSerializer
  include FastJsonapi::ObjectSerializer

  set_type :dispatch
  attributes :is_trunk, :is_pickup, :status_id

  attribute :status do |object|
    if object.is_pickup
      I18n.t("dispatches.pickup_statuses.#{object.status_id}")
    else
      I18n.t("dispatches.normal_statuses.#{object.status_id}")
    end
  end

  attribute :estimated_at do |object|
    object.estimated_at.try(:iso8601)
  end

  attribute :arrived_at do |object|
    object.arrived_at.try(:iso8601)
  end

  attribute :created_at do |object|
    object.created_at.try(:iso8601)
  end

  belongs_to :guide, serializer: :guide, if: proc { |record|
    record.association(:guide).loaded?
  }

  belongs_to :route, serializer: :route, if: proc { |record|
    record.association(:route).loaded?
  }
end
