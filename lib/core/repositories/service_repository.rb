# frozen_string_literal: true

class ServiceRepository < Hanami::Repository
  associations do
    has_many :environments
    has_one :readiness

    has_many :organisation_audit_items

    belongs_to :organisation
  end

  def all_for_organisation(organisation_id)
    aggregate(:readiness).where(organisation_id: organisation_id).map_to(Service).to_a
  end

  def find_for_organisation(organisation_id, key)
    aggregate(:environments, :readiness).where(organisation_id: organisation_id, key: key).limit(1).map_to(Service).one
  end

  def find_with_environments(id)
    aggregate(:environments).by_pk(id).limit(1).map_to(Service).one
  end

  def create_or_upate(organisation_id, payload)
    transaction do
      service = find_for_organisation(organisation_id, payload[:key])

      if service
        payload[:environments].each { |env_paylaod| create_or_upate_env(service, env_paylaod) }
        envs_for_delete = service.environments.map(&:name) - payload[:environments].map { |e| e[:name] }
        mark_deleted_enviroments(envs_for_delete)
        update(service.id, payload)
      else
        assoc(:environments).create(payload)
      end
    end
  end

  private

  def create_or_upate_env(service, env_payload)
    existed_env = service.environments.find { |e| e.name == env_payload[:name] }

    if existed_env
      environment_repo.update(existed_env.id, env_payload)
    else
      environment_repo.create(service_id: service.id, **env_payload)
    end
  end

  def mark_deleted_enviroments(list)
    return if list.empty?

    environments.where(name: list).update(deleted: true)
  end

  def environment_repo
    @environment_repo ||= EnvironmentRepository.new
  end
end
