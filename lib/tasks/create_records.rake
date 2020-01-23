# frozen_string_literal: true

require 'faker'

namespace :create_records do
  desc 'Create a minimun data set to test the automatic guide assignment'
  task :start, [:quantity_records] => :environment do |_, args|
    quantity = args[:quantity_records].to_i
    raise 'Quantity must be present and greather than zero' unless quantity&.positive?

    DatabaseCleaner.clean_with(:truncation)
    destroy_model_data
    create_data(quantity)
  end
end

def destroy_model_data
  models = [Account, Address, Contact, ContactsAddress, CustomField,
            CustomFieldType, CustomFieldTypeValue, DispatchGuide, Dispatch,
            Route, Truck, TruckDriver, TruckDriverAvailability, Place, User]
  models.map(&:destroy_all)
  puts "Destroy all records\n"
end

def print_create(quantity, attr)
  puts "Create #{quantity} #{attr} records\n"
end

def create_data(quantity)
  account = Account.create!(name: 'graphql', email: 'graphql@domain.com', api_key: SecureRandom.hex)
  puts "Create Account #{account.name}\n"

  quantity.times do
    Truck.create!(capacity: rand(0..5), account: account, identifier: Faker::Code.imei, vehicle_type: rand(0..5))
  end
  print_create(quantity, 'trucks')

  account_trucks_ids = account.truck_ids
  quantity.times.each_with_index do |_, index|
    TruckDriver.create!(account: account,
                        name: Faker::Name.name,
                        truck_id: account_trucks_ids[index],
                        username: Faker::Name.first_name,
                        pin_code: rand(1000..9999).to_s)
  end
  print_create(quantity, 'truck_driver')
  quantity.times do
    Place.create!(account: account,
                  name: ['Jumbo', 'Lider', 'Santa Isabel'].sample + SecureRandom.hex,
                  address: 'Bilbao #456',
                  longitude: Random.rand(31.0..33.0) * -1,
                  latitude: Random.rand(69.0..71.0) * -1)
  end
  print_create(quantity, 'places')
  places = account.place_ids
  truck_driver_ids = account.truck_driver_ids
  quantity.times.each_with_index do |_, index|
    TruckDriverAvailability.create!(truck_driver_id: truck_driver_ids[index],
                                    place_id: places[index],
                                    available: true,
                                    longitude: Random.rand(31.0..33.0) * -1,
                                    latitude: Random.rand(69.0..71.0) * -1)
  end
  print_create(quantity, 'truck_driver_availability')
  quantity.times.each_with_index do |_, index|
    Route.create!(
      account: account,
      truck_id: account_trucks_ids[index],
      active: true,
      dispatch_date: DateTime.now,
      started_at: DateTime.now,
      truck_driver_id: truck_driver_ids[index]
    )
  end
  print_create(quantity, 'routes')
  quantity.times do
    Contact.create!(account: account,
                    email: Faker::Internet.email,
                    phone: Faker::PhoneNumber.cell_phone,
                    identifier: SecureRandom.hex,
                    name: Faker::Name.last_name,
                    contact_type: rand(1..10),
                    last_sent_survey: Time.now)
  end
  print_create(quantity, 'contacts')
  quantity.times do
    cities = %w[talca curico santiago copiapo vallenar temuco lima buenos_aires mendoza brasilia]
    countries = %w[chile argentina brasil peru]
    Address.create!(account: account,
                    longitude: Random.rand(31.0..33.0) * -1,
                    latitude: Random.rand(69.0..71.0) * -1,
                    name: cities.sample,
                    name_correct: "city_#{cities.sample}",
                    city: cities.sample,
                    country: countries.sample,
                    state: cities.sample,
                    postal_code: rand(1..10),
                    geocoding_status: rand(0..8))
  end
  print_create(quantity, 'address')
  addresses = account.address_ids
  contacts = account.contact_ids
  quantity.times.each_with_index do |_, index|
    DispatchGuide.create!(beecode: SecureRandom.hex,
                          mode: rand(0..3),
                          pickup_address_id: addresses[index],
                          address_id: addresses[index],
                          service_time: Time.now,
                          max_delivery_time: Time.now,
                          min_delivery_time: Time.now,
                          dispatches_count: 0,
                          first_estimated: Time.now,
                          account: account,
                          contact_id: contacts[index],
                          code: SecureRandom.hex,
                          place_id: places[index],
                          active: true)
  end
  print_create(quantity, 'dispatch_guides')
  dispatch_guide = account.dispatch_guide_ids
  routes = account.route_ids
  quantity.times.each_with_index do |_, index|
    Dispatch.create!(status_id: rand(1..4),
                     has_form: [true, false].sample,
                     estimated_at: Time.now,
                     arrived_at: Time.now,
                     account: account,
                     guide_id: dispatch_guide[index],
                     route_id: routes[index])
  end
  print_create(quantity, 'dispatch')
  quantity.times.each_with_index do |_, index|
    ContactsAddress.create!(address_id: addresses[index], contact_id: contacts[index])
  end
  print_create(quantity, 'contact_address')
  quantity.times do
    CustomFieldType.create(account: account, name: Faker::Internet.slug, model_type: rand(0..3))
  end
  print_create(quantity, 'custom_field_type')
  custom_field_types = CustomFieldType.where(account: account).ids
  quantity.times.each_with_index do |_, index|
    colors = %w[rojo blanco negro azul verde]
    CustomFieldTypeValue.create!(custom_field_type_id: custom_field_types[index], color: colors.sample, value: rand(0..5))
  end
  print_create(quantity, 'custom_field_type_value')
  quantity.times.each_with_index do |_, index|
    CustomField.create!(custom_field_type_id: custom_field_types[index],
                        model_id: truck_driver_ids[index],
                        account: account,
                        model_type: 'TruckDriver',
                        value: Faker::Internet.domain_word)
  end
  print_create(quantity, 'custom_field -- truck_driver model')
  quantity.times.each_with_index do |_, index|
    CustomField.create!(custom_field_type_id: custom_field_types[index],
                        model_id: account.dispatch_guide_ids[index],
                        account: account,
                        model_type: 'DispatchGuide',
                        value: Faker::Internet.domain_word)
  end
  print_create(quantity, 'custom_field -- dispatch_guide model')
  quantity.times.each_with_index do |_, index|
    CustomField.create!(custom_field_type_id: custom_field_types[index],
                        model_id: account.truck_ids[index],
                        account: account,
                        model_type: 'Truck',
                        value: Faker::Internet.domain_word)
  end
  print_create(quantity, 'custom_field -- truck model')
end
