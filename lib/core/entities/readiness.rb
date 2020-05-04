# frozen_string_literal: true

class Service < Hanami::Entity
end

class Readiness < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :service_id, Types::Int
    attribute :service, Types::Entity(Service)

    attribute :owner, Types::Bool
    attribute :slack, Types::Bool
    attribute :healthcheck, Types::Bool
    attribute :logs, Types::Bool
    attribute :error_traker, Types::Bool
    attribute :continuous_integration, Types::Bool
    attribute :api_documentation, Types::Bool
    attribute :maintenance_documentation, Types::Bool
    attribute :monitoring, Types::Bool

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
