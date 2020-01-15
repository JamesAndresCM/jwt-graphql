# frozen_string_literal: true

module Mutations
  class LoginMutation < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true do
      description 'Login for users'
    end

    def resolve(email:, password:)
      user = User.find_for_authentication(email: email)
      return nil unless user

      # https://stackoverflow.com/questions/23147889/lockable-is-not-working-in-devise/43102777
      is_valid_for_auth = user.valid_for_authentication? { user.valid_password?(password) }
      is_valid_for_auth ? { user: user } : nil
    end
  end
end