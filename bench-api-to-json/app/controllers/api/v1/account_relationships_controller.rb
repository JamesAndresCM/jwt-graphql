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
        render json: oj_optimize(result.as_json)
      end
    end
  end
end
