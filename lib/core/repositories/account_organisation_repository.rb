class AccountOrganisationRepository < Hanami::Repository
  associations do
    belongs_to :account
    belongs_to :organisation
  end
end