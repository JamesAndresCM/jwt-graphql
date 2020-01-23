class GuideSerializer
  include FastJsonapi::ObjectSerializer

  set_type :guide
  attribute :code

  attribute :created_at do |object|
    object.created_at.try(:iso8601)
  end

  attribute :min_delivery_time do |object|
    object.min_delivery_time.try(:iso8601)
  end

  attribute :max_delivery_time do |object|
    object.max_delivery_time.try(:iso8601)
  end

  belongs_to :contact, serializer: :contact, if: proc { |record|
    record.association(:contact).loaded?
  }

  belongs_to :address, serializer: :address, if: proc { |record|
    record.association(:address).loaded?
  }

  belongs_to :pickup_address, serializer: :pickup_address, if: proc { |record|
    record.association(:pickup_address).loaded?
  }

  has_many :custom_fields, serializer: :custom_field, if: proc { |record|
    record.association(:custom_fields).loaded?
  }

  has_many :custom_field_types, serializer: :custom_field_type, if: proc { |record|
    record.association(:custom_field_types).loaded?
  }
end
