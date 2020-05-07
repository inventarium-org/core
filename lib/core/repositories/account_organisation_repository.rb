# frozen_string_literal: true

class AccountOrganisationRepository < Hanami::Repository
  associations do
    belongs_to :account
    belongs_to :organisation
  end

  relations :auth_identities, :organisation_invites

  def all_for_organisation(organisation_id)
    aggregate(account: :auth_identities).where(organisation_id: organisation_id).map_to(AccountOrganisation).to_a
  end

  def member?(organisation_id, account_id)
    root.where(organisation_id: organisation_id, account_id: account_id).exist?
  end

  def invite_account(organisation_id, github_or_email)
    # we need this hack for using relations inside where block
    # in future use this way:
    #   https://github.com/rom-rb/rom-sql/blob/39ed49d42319adcdb59e03e40e447401cd7ed4ee/spec/unit/relation/where_spec.rb#L96
    accounts_email = accounts[:email].qualified
    auth_identities_login = auth_identities[:login].qualified

    transaction do
      account = accounts.left_join(auth_identities).where do
        accounts_email.is(github_or_email) | auth_identities_login.is(github_or_email)
      end.limit(1).one

      return unless account

      create(account_id: account.id, organisation_id: organisation_id, role: 'participator')
    end
  end

  def invite_new_account(account_id, email, login)
    transaction do
      organisation_invites
        .where(github_or_email: [email, login])
        .each { |invite| create(account_id: account_id, organisation_id: invite.organisation_id) }
    end
  end
end
