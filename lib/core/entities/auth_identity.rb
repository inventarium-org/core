# frozen_string_literal: true

class Account < Hanami::Entity
end

class AuthIdentity < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :account_id, Types::Int
    attribute :account,    Types::Entity(Account)

    attribute :uid,           Types::String
    attribute :token,         Types::String
    attribute :provider,      ::Core::Types::AuthIdentityProvider
    attribute :login,         Types::String
    attribute :password_hash, Types::String.optional

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
