class CustomFieldSerializer
  include FastJsonapi::ObjectSerializer
  set_type :custom_field

  attributes :value, :custom_field_type_id
end
