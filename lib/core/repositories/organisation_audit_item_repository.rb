# frozen_string_literal: true

class OrganisationAuditItemRepository < Hanami::Repository
  associations do
    belongs_to :organisation
    belongs_to :service
  end

  def list(organisation_id, key: nil, limit: nil)
    relation = root.where(organisation_id: organisation_id)
    relation = relation.where(service_key: key) if key
    relation = relation.limit(limit) if limit

    relation.order { created_at.desc }.map_to(OrganisationAuditItem).to_a
  end
end
