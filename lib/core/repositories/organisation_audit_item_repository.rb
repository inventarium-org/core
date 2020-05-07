# frozen_string_literal: true

class OrganisationAuditItemRepository < Hanami::Repository
  associations do
    belongs_to :organisation
  end
end
