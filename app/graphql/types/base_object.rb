# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField
    # https://www.2n.pl/blog/graphql-pagination-in-rails
    # https://graphql.org/learn/pagination/
    def self.connection_type
      connection_class = super
      connection_class.define_method(:total_count) do
        object.nodes.size
      end

      connection_class.send(:field, :total_count, Integer, null: false)
      connection_class
    end
  end
end
