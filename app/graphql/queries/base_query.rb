# frozen_string_literal: true

module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include Autenticable
  end
end
