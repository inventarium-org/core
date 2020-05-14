# frozen_string_literal: true

class Organisation < Hanami::Entity
end

class Environment < Hanami::Entity
end

class Communication < Hanami::Entity
end

class Service < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :environments, Types::Collection(Environment)
    attribute :communications, Types::Collection(Communication)
    attribute :readiness, Types::Entity(Readiness)

    attribute :organisation_id, Types::Int
    attribute :organisation, Types::Entity(Organisation)

    attribute :version, Types::String

    attribute :key, Types::String
    attribute :name, Types::String
    attribute :description, Types::String
    attribute :languages, Types::Array
    attribute :repository_link, Types::String

    attribute :tags, Types::Array

    attribute :owner_name, Types::String
    attribute :owner_slack_channel, Types::String

    attribute :classification, ::Core::Types::ServiceClassification
    attribute :status, ::Core::Types::ServiceStatus

    attribute :ci_build_url, Types::String

    attribute :docs_api, Types::String
    attribute :docs_maintenance, Types::String
    attribute :docs_domain, Types::String

    attribute :deleted, Types::Bool

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
