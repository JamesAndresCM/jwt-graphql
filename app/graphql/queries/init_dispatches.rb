# frozen_string_literal: true

module Queries
  class InitDispatches < Queries::BaseQuery
    argument :date, Types::DateTimeType, required: true
    argument :filter, String, required: false, default_value: nil
    argument :filter_value, Boolean, required: false, camelize: false, default_value: nil
    type Types::DispatchType.connection_type, null: true

    def resolve(date:, filter:, filter_value:)
      route_ids = today_route_ids(date)
      @result = on_route_dispatches(route_ids).not_managed
      raise GraphQL::ExecutionError, 'not found records' if @result.empty?

      filter && filter_value ? filter_dispatches(filter, filter_value) : @result
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
      raise GraphQL::ExecutionError, "#{filter_arg} is not available in filters" unless filters.include?(filter_arg)

      @result.where(filter_arg.to_sym => filter_value)
    end
  end
end
