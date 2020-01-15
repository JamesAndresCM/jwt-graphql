# frozen_string_literal: true

module Mutations
  class LogoutMutation < Mutations::BaseMutation
    field :status_logout, Boolean, null: true, camelize: false do
      description 'Logout for users'
    end

    # https://github.com/rmosolgo/graphql-ruby/pull/1543 mutation logout{input: {}}
    def resolve
      current_user.update(jti: SecureRandom.uuid)
      { status_logout: true }
    end
  end
end
