# frozen_string_literal: true

module Mutations
  class SendResetPasswordInstructionsMutation < Mutations::BaseMutation
    argument :email, String, required: true
    field :status, Boolean, null: true, camelize: false do
      description 'Send password reset instructions to users email'
    end

    def resolve(email:)
      user = User.find_by_email(email)

      return true unless user

      user.send_reset_password_instructions
      { send_reset_password_instructions: true }
    end
  end
end
