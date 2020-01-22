source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

gem 'bcrypt', '~> 3.1.7'
gem 'devise'
gem 'devise-jwt', '~> 0.5.8'
gem 'email_validator'
gem 'graphql'
gem 'graphql-errors'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'rack-cors'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'redis'
gem 'redis-namespace'
gem 'sidekiq'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner', '~> 1.6'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'letter_opener'
  gem 'rspec-rails', '~> 3.8'
end

group :test do
  gem 'faker', '~> 1.8'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'simplecov', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'graphiql-rails', group: :development
