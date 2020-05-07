# frozen_string_literal: true

class Organisation < Hanami::Entity
end

class OrganisationAuditItem < Hanami::Entity
  attributes do
    attribute :organisation_id, Types::Int
    attribute :organisation,    Types::Entity(Organisation)

    attribute :service_key, Types::String
    attribute :payload, Types::Hash

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
