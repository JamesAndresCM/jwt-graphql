# frozen_string_literal: true

module Autenticable
  def current_user
    context[:current_user] || (raise GraphQL::ExecutionError, 'You need to authenticate to perform this action')
  end
end
