class RouteSerializer
  include FastJsonapi::ObjectSerializer
  set_type :route

  attribute :started_at do |object|
    object.started_at.present? ? object.started_at.iso8601 : nil
  end
  attribute :ended_at do |object|
    object.ended_at.present? ? object.ended_at.iso8601 : nil
  end

  belongs_to :truck_driver, serializer: :truck_driver, if: proc { |record|
    record.association(:truck_driver).loaded?
  }

  belongs_to :truck, serializer: :truck, if: proc { |record|
    record.association(:truck).loaded?
  }

  has_many :dispatches, serializer: :dispatch
end
