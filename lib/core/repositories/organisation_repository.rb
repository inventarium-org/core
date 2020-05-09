# frozen_string_literal: true

class OrganisationRepository < Hanami::Repository
  associations do
    has_many :services
    has_many :organisation_invites
    has_many :organisation_audit_items

    has_many :account_organisations
    has_many :accounts, through: :account_organisations
  end

  def all_for_account(account_id)
    root
      .join(account_organisations)
      .where(account_organisations[:account_id] => account_id)
      .map_to(Organisation).to_a
  end

  def find_for_account(slug, account_id)
    root
      .join(account_organisations)
      .where(account_organisations[:account_id] => account_id)
      .where(slug: slug)
      .map_to(Organisation).one
  end

  def find_by_token(token)
    aggregate(:services).where(token: token).map_to(Organisation).one
  end

  # TODO: add tests
  def create_for_account(account_id, name, slug, token)
    assoc(:account_organisations).create(
      name: name, slug: slug, token: token, plan: 'demo',
      account_organisations: [{ account_id: account_id }]
    )
  end
end
