# frozen_string_literal: true

module Mutations
  class TokenLoginMutation < Mutations::BaseMutation
    field :user, Types::UserType, null: true, camelize: false do
      description 'JWT token login'
    end

    def resolve
      current_user
      { user: context[:current_user] }
    end
  end
end
