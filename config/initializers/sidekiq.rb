# frozen_string_literal: true

redis_host = case Rails.env
             when 'production'
               ''
             when 'release_candidate'
               ''
             else
               ENV['REDIS_URL'] || 'redis://localhost'
             end

Sidekiq.configure_client do |config|
  config.redis = {url: redis_host, namespace: 'rails-devise-graphql'}
end

Sidekiq.configure_server do |config|
  config.redis = {url: redis_host, namespace: 'rails-devise-graphql'}
end
