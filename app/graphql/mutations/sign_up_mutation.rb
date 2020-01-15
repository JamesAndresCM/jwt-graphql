# frozen_string_literal: true

module Mutations
  class SignUpMutation < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true, camelize: false
    argument :firstName, String, required: true
    argument :lastName, String, required: true
    argument :accountEmail, String, required: true

    field :user, Types::UserType, null: true do
      description 'Sign up for users'
    end

    field :errors, Types::ValidationErrorsType, null: true

    def resolve(sign_up_params = {})
      account = Account.where(email: sign_up_params[:account_email]).first

      (raise GraphQL::ExecutionError, "#{sign_up_params[:account_email]} not found") unless account

      user = User.new(
        email: sign_up_params[:email],
        password: sign_up_params[:password],
        password_confirmation: sign_up_params[:password_confirmation],
        first_name: sign_up_params[:first_name],
        last_name: sign_up_params[:last_name],
        account: account
      )

      user.save ? { user: user } : { errors: user.errors }
    end
  end
end
