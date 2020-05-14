# frozen_string_literal: true

class CommunicationRepository < Hanami::Repository
  associations do
    belongs_to :service
  end

  relations :organisations

  def all_for_organisation(organisation_id)
    aggregate(:service).join(services).where(services[:organisation_id].qualified => organisation_id).map_to(Communication).to_a
  end

  # def batch_create(service_id, batch)
  #   data = Array(batch).map { |p| { **p, service_id: service_id } }
  #   command(upsert: :communications, result: :many).call(data)
  # end

  # TODO: specs for command
  def create_update_delete(service, list)
    # TODO: use upsert here instead N+1
    list.each { |payload| create_or_upate(service, payload) }

    for_delete = service.communications.reject do |existed_com|
      list.any? { |c| c[:type] == existed_com.type && c[:target] == existed_com.target }
    end

    mark_deleted(for_delete.map(&:id))
  end

  # TODO: specs for command
  def create_or_upate(service, communication_payload)
    existed_communication = Array(service.communications).find do |c|
      c.type == communication_payload[:type] && c.target == communication_payload[:target]
    end

    if existed_communication
      update(existed_communication.id, deleted: false, **communication_payload)
    else
      create(service_id: service.id, **communication_payload)
    end
  end

  # TODO: specs for command
  def mark_deleted(list)
    return if list.empty?

    root.where(id: list).update(deleted: true)
  end
end
