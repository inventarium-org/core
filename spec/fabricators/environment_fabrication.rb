# frozen_string_literal: true

Fabricator(:environment) do
  service_id { Fabrication(:service).id }

  name 'production'
  description 'Some description about production environment'
  tags %w[test business]

  url 'https://orders.company.com'
  healthcheck_url 'https://orders.company.com/health'
  logs_url 'https://elk.company.net/orders'
  error_traker_url 'https://rollbar.com/company/orders'

  monitoring do
    {
      grafana: 'https://grafana.company.net/orders',
      new_relic: 'https://newrelic.com/company/orders'
    }
  end
end
