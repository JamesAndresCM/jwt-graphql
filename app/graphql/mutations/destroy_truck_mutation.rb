# frozen_string_literal: true

module Mutations
  class DestroyTruckMutation < Mutations::BaseMutation
    argument :truck_id, ID, required: true, camelize: false
    field :status, Boolean, null: true
    field :truck, Types::TruckType, null: true

    def resolve(truck_id)
      truck = current_user.account.trucks.where(id: truck_id[:truck_id])
      raise GraphQL::ExecutionError, "truck id #{truck_id[:truck_id]} not found" if truck.empty?

      truck.first.destroy
      { status: true }
    end
  end
end
