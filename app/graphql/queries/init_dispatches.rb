# frozen_string_literal: true

module Queries
  class InitDispatches < Queries::BaseQuery
    argument :date, Types::DateTimeType, required: true
    type [Types::DispatchType], null: true

    def resolve(date:)
      route_ids = today_route_ids(date)
      result = on_route_dispatches(route_ids).not_managed
      raise GraphQL::ExecutionError, 'not found records' if result.empty?

      result
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
  end
end
