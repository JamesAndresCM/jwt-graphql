module Api
  module V1
    class DispatchesController < ApplicationController
      include PaginatorHelper
      before_action :set_date

      def dispatches
        route_ids = today_route_ids(@date)
        @result = on_route_dispatches(route_ids).not_managed
        render_json_dispatch('api_v1_init_dispatches_path')
      end

      private

      def dispatch_filters
        if dispatch_params[:filter] && dispatch_params[:filter_value]
          filter_dispatches
        else
          @result
        end
      end

      def render_json_dispatch(path)
        @dispatches = dispatch_filters
        links_dispatch = links(path, params, @dispatches.size)
        total_elements = @dispatches.size
        render json: serialize_dispatches(@dispatches,
                                       links_dispatch,
                                       total_elements)
      end

      def serialize_dispatches(data, links, total_elements)
        dispatches = data.offset_object(params)
        DispatchSerializer.new(dispatches,
                               include: ['guide.contact',
                                         'guide.address',
                                         'guide.pickup_address',
                                         'guide.custom_fields',
                                         'guide.custom_field_types'],
                               links: links, meta: meta_data(total_elements, dispatch_params)
                              ).serialized_json
      end

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

      def filter_dispatches
        filters = %w[is_pickup has_form is_trunk]
        return @result unless filters.include?(dispatch_params[:filter])
        
        @result.where(dispatch_params[:filter] => dispatch_params[:filter_value])
      end

      def set_date
        @date = parse_date(dispatch_params[:date]) || Time.zone.now.to_date
      end

      def dispatch_params
        params.permit(:page, :date, :filter, :filter_value)
      end
    end
  end
end
