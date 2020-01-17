# frozen_string_literal: true

module Mutations
  class CreateTrucksMutation < Mutations::BaseMutation
    argument :identifier, String, required: true
    argument :is_ramp, Boolean, required: false, camelize: false
    argument :has_own_gps, Boolean, required: false, camelize: false
    argument :vehicle_type, String, required: true, camelize: false
    argument :capacity, Int, required: true

    field :truck, Types::TruckType, null: true

    field :errors, Types::ValidationErrorsType, null: true

    def resolve(truck_params = {})
      valid_vehicle_type(truck_params[:vehicle_type])
      truck = current_user.account.trucks.build(
        identifier: truck_params[:identifier],
        is_ramp: truck_params[:is_ramp],
        has_own_gps: truck_params[:has_own_gps],
        vehicle_type: truck_params[:vehicle_type],
        capacity: truck_params[:capacity],
        account: current_user.account
      )
      truck.save! ? { truck: truck } : { errors: truck.errors }
    end

    def valid_vehicle_type(vehicle_type)
      types_vehicles = Truck.vehicle_types.keys
      raise GraphQL::ExecutionError, "#{vehicle_type} is not valid vehicle type" unless types_vehicles.include?(vehicle_type)
    end
  end
end
