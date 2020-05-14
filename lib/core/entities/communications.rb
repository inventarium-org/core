# frozen_string_literal: true

class Service < Hanami::Entity
end

class Communications < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :service_id, Types::Int
    attribute :service, Types::Entity(Service)

    attribute :type, Types::String
    attribute :target, Types::String
    attribute :criticality, Types::String

    attribute :resources, Types::Array
    attribute :custom_data, Types::Hash

    attribute :deleted, Types::Bool

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
