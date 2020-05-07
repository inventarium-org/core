# frozen_string_literal: true

class Organisation < Hanami::Entity
end

class OrganisationInvite < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :organisation_id, Types::Int
    attribute :organisation,    Types::Entity(Organisation)

    attribute :inviter_id,      Types::Int
    attribute :github_or_email, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
