# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_up, mutation: Mutations::SignUpMutation
    field :logout, mutation: Mutations::LogoutMutation
    field :login, mutation: Mutations::LoginMutation
    field :tokenLogin, mutation: Mutations::TokenLoginMutation
    field :updateUser, mutation: Mutations::UpdateUserMutation
    field :sendResetPass, mutation: Mutations::SendResetPasswordInstructionsMutation
    field :resetPassword, mutation: Mutations::ResetPasswordMutation
    #
    # uncomment for unlock instructions
    #
    # UNLOCK ACCOUNT
    # field :unlock, Boolean, null: false do
    #   argument :unlockToken, String, required: true
    # end
    # def unlock(unlock_token:)
    #   user = User.unlock_access_by_token(unlock_token)
    #   return user.id
    # end

    # RESEND UNLOCK INSTRUCTIONS
    # field :resend_unlock_instructions, Boolean, null: false do
    #   argument :email, String, required: true
    # end
    # def resend_unlock_instructions(email:)
    #   user = User.find_by_email(email)
    #   return false if !user

    #   user.resend_unlock_instructions
    # end
  end
end
