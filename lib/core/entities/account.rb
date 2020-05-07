# frozen_string_literal: true

class AuthIdentity < Hanami::Entity
end

class Account < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :auth_identities, Types::Collection(AuthIdentity)

    attribute :uuid, ::Core::Types::UUID
    attribute :name, Types::String
    attribute :email, Types::String
    attribute :avatar_url, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
