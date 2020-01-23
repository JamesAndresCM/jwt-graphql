class CustomFieldTypeSerializer
  include FastJsonapi::ObjectSerializer
  set_type :custom_field_type

  attributes :name
end
