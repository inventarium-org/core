class OrganisationRepository < Hanami::Repository
  associations do

    has_many :account_organisations
    has_many :accounts, through: :account_organisations
  end
end
