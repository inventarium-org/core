# frozen_string_literal: true

class OrganisationInviteRepository < Hanami::Repository
  associations do
    belongs_to :organisation
  end
end
