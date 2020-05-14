# frozen_string_literal: true

class EnvironmentRepository < Hanami::Repository
  associations do
    belongs_to :service
  end

  # def batch_create(service_id, batch)
  #   data = Array(batch).map { |p| { **p, service_id: service_id } }
  #   command(create: :environments, result: :many).call(data)
  # end

  # TODO: specs for command
  def create_update_delete(service, list)
    # TODO: use upsert here instead N+1
    list.each { |env_paylaod| create_or_upate(service.id, service.environments, env_paylaod) }
    envs_for_delete = service.environments.map(&:name) - list.map { |e| e[:name] }
    mark_deleted(envs_for_delete)
  end

  # TODO: specs for command
  def create_or_upate(service_id, existed_envs, env_payload)
    existed_env = existed_envs.find { |e| e.name == env_payload[:name] }

    if existed_env
      update(existed_env.id, deleted: false, **env_payload)
    else
      create(service_id: service_id, **env_payload)
    end
  end

  # TODO: specs for command
  def mark_deleted(list)
    return if list.empty?

    root.where(name: list).update(deleted: true)
  end
end
