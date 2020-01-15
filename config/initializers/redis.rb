# frozen_string_literal: true

case Rails.env
when 'production'
  ''
when 'release_candidate'
  ''
else
  ENV['REDIS_URL'] || 'localhost'
end
