class ReadinessRepository < Hanami::Repository
  associations do
    belongs_to :service
  end
  
  def create_or_update(service_id, payload)
    transaction do
      object = root.where(service_id: service_id).limit(1).one

      if object
        update(object.id, payload)
      else
        create(payload)
      end
    end
  end
end
