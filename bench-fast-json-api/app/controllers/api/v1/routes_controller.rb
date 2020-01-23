module Api
  module V1
    class RoutesController < ApplicationController
      include PaginatorHelper
      before_action :set_date

      def index
        @result = current_user.account.routes.open_in(@date).eager_load(
                    truck: :truck_driver, dispatches: {
                    guide: %i[contact address pickup_address custom_fields custom_field_types]}
                )
        render_routes_json('api_v1_open_routes_path')
      end

      private

      def set_date
        @date = parse_date(params[:date]) || Time.zone.now.to_date
      end

      def render_routes_json(path)
        links_routes = links(path, params, @result.size)
        total_elements = @result.size
        render json: serialize_route(@result, links_routes, total_elements)
      end

      def serialize_route(data,links, total_elements)
        routes = data.offset_object(params)
        RouteSerializer.new(routes, include: ['dispatches',
                                              'dispatches.guide',
                                              'dispatches.guide.contact',
                                              'dispatches.guide.address',
                                              'dispatches.guide.pickup_address',
                                              'dispatches.guide.custom_fields','dispatches.guide.custom_field_types'],
                                   links: links,
                                   meta: meta_data(total_elements, links_params)).serialized_json
      end

      def links_params
        params.permit(:page, :date)
      end
    end
  end
end
