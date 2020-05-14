# frozen_string_literal: true

class ServiceRepository < Hanami::Repository
  associations do
    has_many :environments
    has_many :communications
    has_many :organisation_audit_items

    has_one :readiness

    belongs_to :organisation
  end

  def all_for_organisation(organisation_id)
    aggregate(:readiness).where(organisation_id: organisation_id).map_to(Service).to_a
  end

  def find_for_organisation(organisation_id, key)
    aggregate(:environments, :readiness, :communications)
      .where(organisation_id: organisation_id, key: key)
      .limit(1).map_to(Service).one
  end

  def find_with_environments(id)
    aggregate(:environments).by_pk(id).limit(1).map_to(Service).one
  end

  # TODO: good idea to move everything here to command or something like this
  def create_or_upate(organisation_id, payload)
    transaction do
      service = find_for_organisation(organisation_id, payload[:key])
      service ? update(service.id, payload) : create(payload)
      service = find_for_organisation(organisation_id, payload[:key])

      # potentially good idea to move it to env repo
      environment_repo.create_update_delete(service, Array(payload[:environments]))
      communication_repo.create_update_delete(service, Array(payload[:communications]))

      service
    end
  end

  private

  def environment_repo
    @environment_repo ||= EnvironmentRepository.new
  end

  def communication_repo
    @communication_repo ||= CommunicationRepository.new
  end
end
