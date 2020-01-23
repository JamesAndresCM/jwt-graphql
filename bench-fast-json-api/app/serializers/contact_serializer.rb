class ContactSerializer
  include FastJsonapi::ObjectSerializer
  set_type :contact

  attributes :name, :email, :phone
  attribute :identifier do |object|
    object.read_attribute(:identifier)
  end
end
