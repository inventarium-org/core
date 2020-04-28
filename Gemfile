# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.0'

gem 'bigdecimal', '1.4.2'
gem 'rake'

# http layer
gem 'hanami', '1.3.0'
gem 'puma', '~> 3.12.4'

# persistance layer
gem 'hanami-model', '~> 1.3'
gem 'pg'

# dependency managment
gem 'dry-system', '~> 0.9.0'
gem 'dry-system-hanami', github: 'davydovanton/dry-system-hanami'

# templates
gem 'hanami-webpack', github: 'samuelsimoes/hanami-webpack'
gem 'sass'
gem 'slim'

# Monitoring and logging
gem 'semantic_logger'

# business logic section
gem 'dry-monads', '~> 1.1.0'

# background
gem 'hiredis'
gem 'sidekiq'
# gem 'sidekiq-scheduler'

# http calls
gem 'faraday'

# warnings
gem 'warning'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun', platforms: :ruby

  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'

  # data generation and cleanup
  gem 'database_cleaner'
  gem 'hanami-fabrication'

  # style check
  gem 'rubocop', require: false
  gem 'rubocop-rspec', '~> 1.25.0'
end

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'rspec-hanami'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
  gem 'vcr'
  gem 'webmock'
end

group :production do
end

group :plugins do
  gem 'hanami-operation-generator', github: 'davydovanton/hanami-operation-generator'
end
