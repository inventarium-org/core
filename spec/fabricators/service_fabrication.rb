# frozen_string_literal: true

Fabricator(:service) do
  organisation_id { Fabrication(:organisation).id }

  key 'orders-service'
  name 'Orders service'
  description 'Some description about orders service'
  repository_link 'https://github.com/company/orders-service'

  tags ['something', 'business']

  owner_name '@company/orders-eng'
  owner_slack_channel '#orders-core'

  classification 'critical'
  status 'adopt'

  ci_build_url 'https://circleci.com/compamy/orders-service'

  docs_api 'https://swagger.company.net/orders/v1'
  docs_maintenance 'https://company.confluence.com/orders/maintenance'
end
