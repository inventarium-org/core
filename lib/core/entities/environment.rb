# frozen_string_literal: true

class Service < Hanami::Entity
end

class Environment < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :service_id, Types::Int
    attribute :service, Types::Entity(Service)

    attribute :name, Types::String
    attribute :description, Types::String
    attribute :tags, Types::Array

    attribute :url, Types::String
    attribute :healthcheck_url, Types::String
    attribute :logs_url, Types::String
    attribute :error_traker_url, Types::String
    attribute :monitoring, Types::Hash

    attribute :deleted, Types::Bool

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
