# frozen_string_literal: true

Fabricator(:readiness) do
  service_id { Fabricate(:service).id }

  owner true
  slack true
  healthcheck false
  logs true
  error_traker true
  continuous_integration true
  api_documentation false
  maintenance_documentation false
  monitoring false
end
