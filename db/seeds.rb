# frozen_string_literal: true

require 'faker'

TruckDriver.destroy_all
Truck.destroy_all
Place.destroy_all
Account.destroy_all
Contact.destroy_all
Address.destroy_all
ContactsAddress.destroy_all
CustomFieldType.destroy_all
CustomField.destroy_all
CustomFieldTypeValue.destroy_all


Account.create!(name: 'graphql', email: 'graphql@domain.com', api_key: SecureRandom.hex)

4.times do |_i|
  Account.create!(api_key: SecureRandom.hex,name: Faker::Name.unique.name, email: Faker::Internet.unique.email)
end

30.times do |_i|
  Truck.create!(capacity: rand(0..5), account_id: Account.all.sample.id, identifier: Faker::Code.unique.imei, vehicle_type: rand(0..5))
end

30.times do |_i|
  truck_id = (Truck.ids - TruckDriver.all.map(&:truck_id)).sample
  account = Truck.find(truck_id).account

  TruckDriver.create!(account_id: account.id, name: Faker::Name.unique.name, truck_id: truck_id, username: Faker::Name.unique.first_name, pin_code: rand(1000..9999).to_s)
end

20.times do |_i|
  Place.create!(account_id: Account.all.sample.id, name: ['Jumbo', 'Lider', 'Santa Isabel'].sample + SecureRandom.hex, address: 'Bilbao #456', longitude: Random.rand(31.0..33.0) * -1, latitude: Random.rand(69.0..71.0) * -1)
end

50.times do |_i|
  account = Account.all.sample

  TruckDriverAvailability.create!(truck_driver_id: account.truck_drivers.sample.id, place_id: account.places.sample.id, available: [false, true].sample, longitude: Random.rand(31.0..33.0) * -1, latitude: Random.rand(69.0..71.0) * -1)
end

75.times do |_i|
  account = Account.all.sample

  Route.create!(
    account_id: account.id,
    truck_id: account.trucks.sample.id,
    active: [true, false].sample,
    dispatch_date: Random.rand((DateTime.now - 2.hour)..(DateTime.now - 1.hour)),
    started_at: Random.rand((DateTime.now - 5.hour)..(DateTime.now - 3.hour)),
    truck_driver_id: account.truck_drivers.sample.id
  )
end

50.times do
  Contact.create!(account_id: Account.all.sample.id, email: Faker::Internet.unique.email, phone: Faker::PhoneNumber.unique.cell_phone, identifier: SecureRandom.hex, name: Faker::Name.unique.last_name, contact_type: rand(1..10), last_sent_survey: Time.now)
end

50.times do
  cities = %w[talca curico santiago copiapo vallenar temuco lima buenos_aires mendoza brasilia]
  countries = %w[chile argentina brasil peru]
  Address.create!(account_id: Account.all.sample.id, longitude: Random.rand(31.0..33.0) * -1, latitude: Random.rand(69.0..71.0) * -1, name: cities.shuffle.first, name_correct: "city_#{cities.shuffle.first}", city: cities.shuffle.first, country: countries.shuffle.first, state: cities.shuffle.first , postal_code: rand(1..10), geocoding_status: rand(0..8))
end

50.times do |_i|
  account = Account.all.sample
  DispatchGuide.create!(beecode: SecureRandom.hex, mode: rand(0..3), pickup_address_id: account.addresses.sample.id, address_id: account.addresses.sample.id,service_time: Time.now, max_delivery_time: Time.now, min_delivery_time: Time.now,dispatches_count: 0, first_estimated: Time.now, account_id: account.id, contact_id: account.contacts.sample.id, code: SecureRandom.hex, place_id: account.places.sample.id, active: true)
end

50.times do |_i|
  account = Account.first
  DispatchGuide.create!(beecode: SecureRandom.hex, mode: rand(0..3), pickup_address_id: account.addresses.sample.id, address_id: account.addresses.sample.id,service_time: Time.now, max_delivery_time: Time.now, min_delivery_time: Time.now,dispatches_count: 0, first_estimated: Time.now, account_id: account.id, contact_id: account.contacts.sample.id, code: SecureRandom.hex, place_id: account.places.sample.id, active: true)
end

20.times do |_i|
  account = Account.all.sample

  Dispatch.create!(status_id: rand(1..4), has_form: [true, false].sample, estimated_at: Time.now, arrived_at: Time.now, account_id: account.id, guide_id: account.dispatch_guides.sample.id, route_id: account.routes.sample.id)
end

20.times do |_i|
  account = Account.first
  Dispatch.create!(status_id: rand(1..4), has_form: [true, false].sample, estimated_at: Time.now, arrived_at: Time.now, account_id: account.id, guide_id: account.dispatch_guides.sample.id, route_id: account.routes.sample.id)
end

50.times do
  address = Address.all.sample
  contacts = Contact.all.sample
  ContactsAddress.create!(address_id: address.id, contact_id: contacts.id)
end

100.times do
  CustomFieldType.create(account_id: Account.all.sample.id, name: Faker::Internet.unique.slug, model_type: rand(0..3))
end

100.times do
  colors = %w[rojo blanco negro azul verde]
  custom_field_type = CustomFieldType.all.sample
  CustomFieldTypeValue.create!(custom_field_type_id: custom_field_type.id, color: colors.shuffle.first, value: rand(0..5))
end

25.times do
  account = Account.all.sample
  CustomField.create!(custom_field_type_id: CustomFieldType.all.sample.id, model_id: account.truck_drivers.sample.id, account_id: account.id, model_type: 'TruckDriver', value: Faker::Internet.unique.domain_word)
end

50.times do
  account = Account.all.sample
  CustomField.create!(custom_field_type_id: CustomFieldType.all.sample.id,model_id: account.dispatch_guides.sample.id, account_id: account.id, model_type: 'DispatchGuide', value: Faker::Internet.unique.domain_word)
end

25.times do
  account = Account.all.sample
  CustomField.create!(custom_field_type_id: CustomFieldType.all.sample.id, model_id: account.trucks.sample.id, account_id: account.id, model_type: 'Truck', value: Faker::Internet.unique.domain_word)
end

