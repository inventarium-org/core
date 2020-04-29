# frozen_string_literal: true

require 'dry/system/components'

Container.boot(:settings, from: :system) do
  settings do
    Types = Core::Types

    key :database_url, Types::String.constrained(filled: true)
    key :database_connection_validation_timeout, Types::Coercible::Int.optional # in seconds

    key :web_sessions_secret, Types::String.constrained(filled: true)

    key :logger_json_formatter, Types::String
    key :logger_level,          Types::LoggerLevel

    key :redistogo_url, Types::Coercible::String.default('')

    key :rollbar_key, Types::Coercible::String.default('')

    key :github_key, Types::String.constrained(filled: true)
    key :github_secret, Types::String.constrained(filled: true)
  end
end
