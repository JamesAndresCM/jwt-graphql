# frozen_string_literal: true

module Queries
  class OpenRoutes < Queries::BaseQuery
    description 'Returns open routes by current_user and date argument'
    argument :date, Types::DateTimeType, required: true
    type [Types::RouteType], null: true

    def resolve(date:)
      result = current_user.account.routes.open_in(date).eager_load(
        truck: :truck_driver, dispatches: {
          guide: %i[contact address pickup_address custom_fields custom_field_types]
        }
      )
      raise GraphQL::ExecutionError, 'not found records' if result.empty?

      result
    end
  end
end
