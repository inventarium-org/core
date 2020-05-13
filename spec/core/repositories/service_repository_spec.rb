# frozen_string_literal: true

RSpec.describe ServiceRepository, type: :repository do
  let(:repo) { described_class.new }
  let(:env_repo) { EnvironmentRepository.new }

  let(:organisation) { Fabricate(:organisation, name: 'service repository test', slug: 'service-repo') }

  describe '#all_for_organisation' do
    subject { repo.all_for_organisation(organisation.id) }

    context 'when organisation has services' do
      before do
        3.times do
          Fabricate(:service, organisation_id: organisation.id)
        end
      end

      it do
        expect(subject).to all(be_a(Service))
        expect(subject.map(&:organisation_id)).to all(eq(organisation.id))
      end
    end

    context 'when organisation does not have any services' do
      it { expect(subject).to eq([]) }
    end
  end

  describe '#find_for_organisation' do
    subject { repo.find_for_organisation(organisation.id, 'test-service') }

    context 'when organisation has services' do
      let(:service) { Fabricate(:service, organisation_id: organisation.id, key: 'test-service') }

      before do
        3.times { |i| Fabricate(:environment, service_id: service.id, name: "Test env #{i}") }

        Fabricate(:environment, name: 'Test env {i}')
        Fabricate(:readiness, service_id: service.id)
      end

      it do
        expect(subject).to eq(service)
        expect(subject.environments.count).to eq(3)
        expect(subject.environments).to all(be_a(Environment))
        expect(subject.readiness).to be_a(Readiness)
      end
    end

    context 'when organisation does not have any services' do
      it { expect(subject).to eq(nil) }
    end
  end

  describe '#find_with_environments' do
    subject { repo.find_with_environments(service.id) }

    context 'when organisation has services' do
      let(:service) { Fabricate(:service, organisation_id: organisation.id) }

      before do
        3.times { |i| Fabricate(:environment, service_id: service.id, name: "Test env #{i}") }

        Fabricate(:environment, name: 'Test env {i}')
      end

      it do
        expect(subject).to eq(service)
        expect(subject.environments.count).to eq(3)
        expect(subject.environments).to all(be_a(Environment))
      end
    end

    context 'when organisation does not have any services' do
      let(:service) { Service.new(id: nil) }

      it { expect(subject).to eq(nil) }
    end
  end

  describe '#create_or_upate' do
    subject { repo.create_or_upate(organisation.id, payload) }

    let(:payload) do
      {
        organisation_id: organisation.id,
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
            name: 'stage',
            tags: ['specific gateway'],
            url: 'https://billing.stage-company.com',
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
        ]
      }
    end

    context 'when service exists in db' do
      let(:service) do
        Fabricate(:service, organisation_id: organisation.id, key: 'billing-service', description: 'empty')
      end

      before do
        Fabricate(:environment, service_id: service.id, name: 'qa')
        Fabricate(:environment, service_id: service.id, name: 'production')
        Fabricate(:environment, service_id: service.id, name: 'stage')
      end

      it { expect { subject }.to change { repo.all.count }.by(0) }

      it do
        expect(subject).to be_a(Service)
        expect(subject.description).to eq('Billing and accounting service')
        expect(subject.languages).to eq(%w[ruby js])
        expect(subject.organisation_id).to eq(organisation.id)
      end

      it 'updates or create new environments' do
        expect(env_repo.all.count).to be(3)
        service = subject

        envs = env_repo.all
        expect(envs.count).to be(4)
        expect(envs.map(&:name)).to eq(%w[qa production stage demo])
        expect(envs.map(&:service_id)).to all(eq(service.id))

        prod_env = envs.find { |e| e.name == 'production' }
        expect(prod_env.description).to eq('Real production env for service')
        expect(prod_env.deleted).to eq(false)

        stage_env = envs.find { |e| e.name == 'stage' }
        expect(stage_env.tags).to eq(['specific gateway'])
        expect(stage_env.deleted).to eq(false)

        qa_env = envs.find { |e| e.name == 'qa' }
        expect(qa_env.deleted).to eq(true)
      end
    end

    context 'when service does not exist in db' do
      it { expect { subject }.to change { repo.all.count }.by(1) }

      it do
        expect(subject).to be_a(Service)
        expect(subject.key).to eq('billing-service')
        expect(subject.organisation_id).to eq(organisation.id)
      end

      context 'and environments present' do
        it 'creates new env objects related to service object' do
          service = subject

          envs = env_repo.all
          expect(envs.count).to eq(3)
          expect(envs.map(&:service_id)).to all(eq(service.id))
        end
      end

      context 'and environments are empty' do
        let(:payload) do
          {
            organisation_id: organisation.id,
            version: 'v0',
            key: 'billing-service',
            name: 'Billing Service for testing',
            description: 'Billing and accounting service'
          }
        end

        it 'creates new env objects related to service object' do
          expect(subject).to be_a(Service)
          expect(subject.key).to eq('billing-service')

          expect(env_repo.all).to eq []
        end
      end
    end

    context 'when data without any changes' do
      before { subject }

      it { expect(subject).to be_a(Service) }
      it { expect { subject }.to change { repo.all.count }.by(0) }
    end

    context 'when data is absolutly empty' do
      let(:payload) { {} }

      it { expect { subject }.to raise_error(Hanami::Model::NotNullConstraintViolationError) }
    end
  end
end
