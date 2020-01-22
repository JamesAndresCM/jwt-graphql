# frozen_string_literal: true

module Mutations
  class ResetPasswordMutation < Mutations::BaseMutation
    argument :password, String, required: true
    argument :password_confirmation, String, required: true, camelize: false
    argument :reset_password_token, String, required: true, camelize: false

    field :status, Boolean, null: true, camelize: false do
      description 'Reset user password'
    end

    def resolve(password:, password_confirmation:, reset_password_token:)
      user = User.find_by_reset_password_token(reset_password_token)
      raise GraphQL::ExecutionError, 'Error to change password' unless user

      user.reset_password(password, password_confirmation)
      { status: user }
    end
  end
end
