# frozen_string_literal: true

class AccountOrganisationRepository < Hanami::Repository
  associations do
    belongs_to :account
    belongs_to :organisation
  end

  relations :auth_identities

  def all_for_organisation(organisation_id)
    aggregate(account: :auth_identities).where(organisation_id: organisation_id).map_to(AccountOrganisation).to_a
  end

  def member?(organisation_id, account_id)
    root.where(organisation_id: organisation_id, account_id: account_id).exist?
  end
end
