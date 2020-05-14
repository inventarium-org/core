# frozen_string_literal: true

Fabricator(:communication) do
  service_id { Fabricate(:service).id }

  type 'http'
  target 'order-service'
  criticality 'critical'
end
