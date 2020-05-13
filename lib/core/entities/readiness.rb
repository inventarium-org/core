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

  CHECK_NAMES = %i[
    owner slack healthcheck logs error_traker continuous_integration
    api_documentation maintenance_documentation monitoring
  ].freeze

  def completed_checks_count
    to_h.slice(*CHECK_NAMES).values.count(true)
  end

  def all_checks_completed?
    CHECK_NAMES.count == completed_checks_count
  end
end
