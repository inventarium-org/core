# frozen_string_literal: true

class Account < Hanami::Entity
end

class Organisation < Hanami::Entity
end

class AccountOrganisation < Hanami::Entity
  OWNER_ROLE = 'owner'

  attributes do
    attribute :id, Types::Int

    attribute :account_id, Types::Int
    attribute :account,    Types::Entity(Account)

    attribute :organisation_id, Types::Int
    attribute :organisation,    Types::Entity(Organisation)

    attribute :role, ::Core::Types::AccountOrganisationRole

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end

  def owner?
    role == OWNER_ROLE
  end
end
