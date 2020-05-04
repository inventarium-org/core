# frozen_string_literal: true

RSpec.describe Services::Mappers::ServiceInformation, type: :mapper do
  subject { operation.call(payload) }

  let(:operation) { described_class.new }

  context 'when data is valid' do
    let(:payload) { Testing::ServiceYamlPayload.generate }

    it 'maps information for specific schema' do
      expect(subject).to eq({
                              key: 'billing-service',
                              name: 'Billing Service for testing',

                              description: 'Billing and accounting service',
                              repository_link: 'https://github.com/company/billing',

                              tags: %w[business billing],

                              owner_name: '@billing/core',
                              owner_slack_channel: '#billing-core',

                              classification: 'critical',
                              status: 'adopt',

                              ci_build_url: 'https://circleci.com/compamy/billing',

                              docs_api: 'https://swagger.company.net/billing/v1',
                              docs_maintenance: 'https://company.confluence.com/billing/maintenance',
                              docs_domain: 'https://company.confluence.com/financial',

                              environments: [
                                {
                                  name: 'production',
                                  description: 'Real production env for service',
                                  tags: ['test', 'specific gateway'],

                                  url: 'https://billing.company.com',
                                  healthcheck_url: 'https://billing.company.com/health',
                                  logs_url: 'https://elk.company.net/billing',
                                  error_traker_url: 'https://rollbar.com/company/billing',
                                  monitoring: {
                                    grafana: 'https://grafana.company.net/billing',
                                    new_relic: 'https://newrelic.com/company/billing'
                                  }
                                },
                                {
                                  name: 'staging',

                                  url: 'https://billing.stage-company.com',
                                  healthcheck_url: 'https://billing.stage-company.com/health',
                                  logs_url: 'https://elk.stage-company.net/billing',
                                  error_traker_url: 'https://rollbar.com/company/billing',
                                  monitoring: {
                                    grafana: 'https://grafana.stage-company.net/billing'
                                  }
                                },

                                {
                                  name: 'demo',
                                  description: 'We use it only for our clients',

                                  url: 'https://billing.demo-company.com',
                                  healthcheck_url: 'https://billing.demo-company.com/health',
                                  tags: ['only for testing']
                                }
                              ]
                            })
    end
  end

  context 'when params object is empty' do
    let(:payload) { {} }

    it { expect(subject).to eq({}) }
  end
end
