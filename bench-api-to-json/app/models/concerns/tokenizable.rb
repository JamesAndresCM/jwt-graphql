# frozen_string_literal: true

require 'active_support/concern'

module Tokenizable
  extend ActiveSupport::Concern
  # https://github.com/waiting-for-dev/devise-jwt/blob/master/lib/devise/jwt/test_helpers.rb

  included do
    def token
      token, payload = user_encoder.call(self, devise_scope, aud_headers)
      token
    end

    private

    def devise_scope
      @devise_scope ||= Devise::Mapping.find_scope!(self)
    end

    def user_encoder
      Warden::JWTAuth::UserEncoder.new
    end

    def aud_headers
      token_headers[Warden::JWTAuth.config.aud_header]
    end

    def token_headers
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end
  end
end

