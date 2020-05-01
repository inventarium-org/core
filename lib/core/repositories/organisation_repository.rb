class OrganisationRepository < Hanami::Repository
  associations do
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
end
