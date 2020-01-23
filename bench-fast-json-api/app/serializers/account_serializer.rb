class AccountSerializer
  include FastJsonapi::ObjectSerializer
  set_type :account
  has_many :trucks, serializer: :truck
end
