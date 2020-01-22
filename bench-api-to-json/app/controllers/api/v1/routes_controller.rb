module Api
  module V1
    class RoutesController < ApplicationController
      before_action :set_date

      def index
        result = current_user.account.routes.open_in(@date).eager_load(
                    truck: :truck_driver, dispatches: {
                    guide: %i[contact address pickup_address custom_fields custom_field_types]}
                )
        data = paginate_object(result)
        render json: data.empty? ? {} : oj_optimize(data)
        #render json: result.empty? ? {} : Yajl::Encoder.encode(result)
        #render json: result.empty? ? {} : result
      end

      private

      def set_date
        @date = parse_date(params[:date]) || Time.zone.now.to_date
      end
    end
  end
end
