# frozen_string_literal: true

module Mutations
  class UpdateUserMutation < Mutations::BaseMutation
    argument :first_name, String, required: false, camelize: false
    argument :last_name, String, required: false, camelize: false
    argument :password_confirmation, String, required: true, camelize: false
    argument :password, String, required: true

    field :user, Types::UserType, null: true, camelize: false do
      description 'Update user'
    end
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(first_name: nil, last_name: nil, password_confirmation: nil, password: nil)
      if current_user.update(first_name: first_name, last_name: last_name, password: password, password_confirmation: password_confirmation)
        { user: current_user }
      else
        { errors: current_user.errors }
      end
    end
  end
end
