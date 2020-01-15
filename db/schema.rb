# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_14_235745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "type"
    t.string "timezone", default: "Santiago"
    t.string "api_key", limit: 72
    t.boolean "chat_enabled", default: false
    t.string "language", default: "es"
    t.string "country", limit: 2, default: "CL"
    t.boolean "active", default: true
    t.boolean "has_ondemand", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name"
    t.string "name_correct"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.decimal "latitude", precision: 18, scale: 10
    t.decimal "latitude_proposed", precision: 18, scale: 10
    t.decimal "longitude", precision: 18, scale: 10
    t.decimal "longitude_proposed", precision: 18, scale: 10
    t.string "country"
    t.integer "geocoding_status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_addresses_on_account_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "email"
    t.string "phone"
    t.string "identifier"
    t.string "name"
    t.integer "contact_type", default: 0, null: false
    t.datetime "last_sent_survey"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_contacts_on_account_id"
  end

  create_table "contacts_addresses", force: :cascade do |t|
    t.bigint "address_id", null: false
    t.bigint "contact_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_contacts_addresses_on_address_id"
    t.index ["contact_id"], name: "index_contacts_addresses_on_contact_id"
  end

  create_table "custom_field_type_values", force: :cascade do |t|
    t.bigint "custom_field_type_id", null: false
    t.string "color"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["custom_field_type_id"], name: "index_custom_field_type_values_on_custom_field_type_id"
  end

  create_table "custom_field_types", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name"
    t.integer "model_type", default: 0
    t.boolean "show_in_web", default: true
    t.boolean "show_in_mobile", default: true
    t.boolean "has_many_flag", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id", "model_type", "show_in_mobile"], name: "cf_by_mobile"
    t.index ["account_id", "model_type", "show_in_web"], name: "cf_by_web"
    t.index ["account_id", "name", "model_type"], name: "cft_account_name_type"
    t.index ["account_id"], name: "index_custom_field_types_on_account_id"
  end

  create_table "custom_fields", force: :cascade do |t|
    t.bigint "custom_field_type_id", null: false
    t.bigint "account_id", null: false
    t.integer "model_id"
    t.string "model_type"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_custom_fields_on_account_id"
    t.index ["custom_field_type_id"], name: "index_custom_fields_on_custom_field_type_id"
  end

  create_table "dispatch_guides", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "code"
    t.integer "dispatches_count"
    t.bigint "place_id", null: false
    t.datetime "first_estimated"
    t.integer "service_time"
    t.datetime "min_delivery_time"
    t.datetime "max_delivery_time"
    t.string "beecode"
    t.boolean "active"
    t.integer "mode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "contact_id", null: false
    t.bigint "address_id"
    t.integer "pickup_address_id"
    t.index ["account_id"], name: "index_dispatch_guides_on_account_id"
    t.index ["address_id"], name: "index_dispatch_guides_on_address_id"
    t.index ["contact_id"], name: "index_dispatch_guides_on_contact_id"
    t.index ["pickup_address_id"], name: "index_dispatch_guides_on_pickup_address_id"
    t.index ["place_id"], name: "index_dispatch_guides_on_place_id"
  end

  create_table "dispatches", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "guide_id"
    t.bigint "route_id", null: false
    t.integer "status_id"
    t.datetime "estimated_at"
    t.datetime "arrived_at"
    t.integer "slot"
    t.boolean "has_form"
    t.boolean "is_trunk"
    t.boolean "is_pickup"
    t.integer "end_type"
    t.integer "delivery_time"
    t.boolean "is_deleted"
    t.float "load"
    t.integer "priority"
    t.boolean "delivered_in_client"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_dispatches_on_account_id"
    t.index ["route_id"], name: "index_dispatches_on_route_id"
  end

  create_table "places", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name"
    t.string "address"
    t.decimal "latitude", precision: 9, scale: 6
    t.decimal "longitude", precision: 9, scale: 6
    t.boolean "is_deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_places_on_account_id"
  end

  create_table "routes", force: :cascade do |t|
    t.bigint "truck_id", null: false
    t.boolean "active"
    t.date "dispatch_date"
    t.string "start_time", default: "09:00:00"
    t.integer "minutes_between", default: 20
    t.string "end_time", default: "09:00:00"
    t.datetime "started_at"
    t.boolean "ended", default: false
    t.datetime "ended_at"
    t.bigint "truck_driver_id", null: false
    t.float "kpi_distance"
    t.float "kpi_max_speed"
    t.float "kpi_avg_speed"
    t.float "kpi_time"
    t.float "kpi_stop_time"
    t.bigint "account_id", null: false
    t.boolean "enable_estimations"
    t.text "encoded_optimal_path"
    t.boolean "start_in_place"
    t.text "initial_dispatches_order"
    t.integer "planned_distance"
    t.integer "real_distance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_routes_on_account_id"
    t.index ["truck_driver_id"], name: "index_routes_on_truck_driver_id"
    t.index ["truck_id"], name: "index_routes_on_truck_id"
  end

  create_table "truck_driver_availabilities", force: :cascade do |t|
    t.bigint "truck_driver_id", null: false
    t.bigint "place_id", null: false
    t.boolean "available"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["place_id"], name: "index_truck_driver_availabilities_on_place_id"
    t.index ["truck_driver_id"], name: "index_truck_driver_availabilities_on_truck_driver_id"
  end

  create_table "truck_drivers", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.bigint "truck_id", null: false
    t.string "telephone"
    t.string "pin_code"
    t.string "unique_hash"
    t.boolean "active"
    t.string "app_version"
    t.bigint "account_id", null: false
    t.string "device_name"
    t.string "os_version"
    t.boolean "picture_approved"
    t.string "picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_truck_drivers_on_account_id"
    t.index ["truck_id"], name: "index_truck_drivers_on_truck_id"
  end

  create_table "trucks", force: :cascade do |t|
    t.string "identifier"
    t.boolean "is_ramp", default: false
    t.boolean "active", default: true
    t.boolean "has_own_gps", default: false
    t.integer "vehicle_type"
    t.float "capacity"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_trucks_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "confirmation_token"
    t.datetime "confirmated_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "role"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "jti", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "accounts"
  add_foreign_key "contacts", "accounts"
  add_foreign_key "contacts_addresses", "addresses"
  add_foreign_key "contacts_addresses", "contacts"
  add_foreign_key "custom_field_type_values", "custom_field_types"
  add_foreign_key "custom_field_types", "accounts"
  add_foreign_key "custom_fields", "accounts"
  add_foreign_key "custom_fields", "custom_field_types"
  add_foreign_key "dispatch_guides", "accounts"
  add_foreign_key "dispatch_guides", "addresses"
  add_foreign_key "dispatch_guides", "contacts"
  add_foreign_key "dispatch_guides", "places"
  add_foreign_key "dispatches", "accounts"
  add_foreign_key "dispatches", "routes"
  add_foreign_key "places", "accounts"
  add_foreign_key "routes", "accounts"
  add_foreign_key "routes", "truck_drivers"
  add_foreign_key "routes", "trucks"
  add_foreign_key "truck_driver_availabilities", "places"
  add_foreign_key "truck_driver_availabilities", "truck_drivers"
  add_foreign_key "truck_drivers", "accounts"
  add_foreign_key "truck_drivers", "trucks"
  add_foreign_key "trucks", "accounts"
end
