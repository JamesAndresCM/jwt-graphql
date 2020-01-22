module Api
  module V1
    class DispatchesController < ApplicationController
      before_action :set_date

      def dispatches
        route_ids = today_route_ids(@date)
        @result = on_route_dispatches(route_ids).not_managed
        data = paginate_object(@result)

        render json: { msg: 'not found records' } if data.empty? and return

        render json: dispatch_params[:filter] && dispatch_params[:filter_value] ? filter_dispatches(dispatch_params[:filter], dispatch_params[:filter_value]) : oj_optimize(data)  and return
      end

      private

      def today_route_ids(date)
        current_user.account.routes
                    .in_date(date)
                    .where(active: true)
                    .pluck(:id)
      end

      def on_route_dispatches(route_ids)
        current_user.account.dispatches
                    .where(route_id: route_ids)
                    .where(is_deleted: false)
                    .eager_load(guide: %i[contact address pickup_address custom_fields custom_field_types], route: %i[truck truck_driver])
                    .where(dispatch_guides: { active: true })
      end

      def filter_dispatches(filter_arg, filter_value)
        filters = %w[is_pickup has_form is_trunk]
        return { error: "#{filter_arg} is not available in filters" }  unless filters.include?(filter_arg)

        res = @result.where(filter_arg.to_sym => filter_value)
        data = paginate_object(res)
        oj_optimize(data)
      end

      def set_date
        @date = parse_date(dispatch_params[:date]) || Time.zone.now.to_date
      end

      def dispatch_params
        params.permit(:date, :filter, :filter_value)
      end
    end
  end
end
