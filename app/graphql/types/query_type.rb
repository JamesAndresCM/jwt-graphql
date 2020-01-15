# frozen_string_literal: true

module Types
  class QueryType < BaseObject
    field :account_open_routes, resolver: Queries::OpenRoutes, camelize: false
    field :initDispatches, resolver: Queries::InitDispatches
    field :current_user, resolver: Queries::CurrentUser, camelize: false
  end
end
