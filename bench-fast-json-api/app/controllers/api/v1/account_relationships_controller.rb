module Api
  module V1
    class AccountRelationshipsController < ApplicationController
      def index
        result = current_user.account.truck_drivers.eager_load(
          :truck_driver_availabilities,
          truck:
          {
            routes: {
              dispatches: {
                guide: %i[contact address custom_fields custom_field_types]
              }
            }
          }
        )
        render json: serialized_truck_driver(result)
      end

      private

      def serialized_truck_driver(element)
        TruckDriverSerializer.new(element, include: ['truck_driver_availabilities', 'truck.routes', 'routes.dispatches'])
      end
    end
  end
end
