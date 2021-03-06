# frozen_string_literal: true

RSpec.describe Services::Mappers::ServiceInformation, type: :mapper do
  subject { mapper.call(payload) }

  let(:mapper) { described_class.new }

  context 'when data is valid' do
    let(:payload) { Testing::ServiceYamlPayload.generate }

    it 'maps information for specific schema' do
      expect(subject).to eq({
                              version: 'v0',

                              key: 'billing-service',
                              name: 'Billing Service for testing',

                              description: 'Billing and accounting service',
                              languages: %w[ruby js],
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
                                  error_tracker_url: 'https://rollbar.com/company/billing',
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
                                  error_tracker_url: 'https://rollbar.com/company/billing',
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
                              ],
                              communications: [
                                {
                                  type: 'http',
                                  target: 'order-service',
                                  criticality: 'critical'
                                },
                                {
                                  type: 'event-producer',
                                  target: 'kafka',
                                  criticality: 'critical',
                                  resources: %w[
                                    orders-topic
                                    notification-topic
                                  ],
                                  custom_data: {
                                    events: %w[
                                      test-event
                                      other-event
                                    ]
                                  }
                                }
                              ]
                            })
    end
  end

  context 'when params object does not have any environments' do
    let(:payload) do
      params = Testing::ServiceYamlPayload.generate
      params.delete(:environments)
      params
    end

    it { expect(subject).to be_a(Hash) }
  end

  context 'when params object is empty' do
    let(:payload) { {} }

    it { expect(subject).to eq({}) }
  end
end
