# frozen_string_literal: true

RSpec.describe Services::Mappers::ReadinessStatus, type: :mapper do
  subject { mapper.call(service) }

  let(:mapper) { described_class.new }

  context 'when service has all information' do
    let(:service) do
      Service.new(
        id: 1,
        owner_name: 'inventarium team',
        owner_slack_channel: '#slack',

        ci_build_url: 'circleci.com',
        docs_api: 'github.com/inventarium-org/core',
        docs_maintenance: 'github.com/inventarium-org/core',

        environments: [
          {
            name: 'production',
            healthcheck_url: 'inventarium.io',
            error_traker_url: 'inventarium.io',
            logs_url: 'inventarium.io',
            monitoring: { new_relic: 'test' }
          }
        ]
      )
    end

    it do
      expect(subject).to eq(
        {
          service_id: 1,

          owner: true,
          slack: true,

          continuous_integration: true,
          api_documentation: true,
          maintenance_documentation: true,

          healthcheck: true,
          monitoring: true,
          error_traker: true,
          logs: true
        }
      )
    end
  end

  context 'when service has part of information' do
    let(:service) do
      Service.new(
        id: 1,
        owner_name: 'inventarium team',
        ci_build_url: 'circleci.com',
        docs_maintenance: 'github.com/inventarium-org/core',

        environments: [
          {
            name: 'production',
            healthcheck_url: 'inventarium.io',
            monitoring: { new_relic: 'test' }
          }
        ]
      )
    end

    it do
      expect(subject).to eq(
        {
          service_id: 1,

          owner: true,
          slack: false,

          continuous_integration: true,
          api_documentation: false,
          maintenance_documentation: true,

          healthcheck: true,
          monitoring: true,
          error_traker: false,
          logs: false
        }
      )
    end
  end

  context 'when service does not have production environments' do
    let(:service) do
      Service.new(
        id: 1,
        owner_name: 'inventarium team',
        ci_build_url: 'circleci.com',
        docs_maintenance: 'github.com/inventarium-org/core',

        environments: [
          {
            name: 'stage',
            healthcheck_url: 'inventarium.io',
            monitoring: { new_relic: 'test' }
          }
        ]
      )
    end

    it do
      expect(subject).to eq(
        {
          service_id: 1,

          owner: true,
          slack: false,

          continuous_integration: true,
          api_documentation: false,
          maintenance_documentation: true
        }
      )
    end
  end

  context 'when service entity has no data' do
    let(:service) { Service.new(id: 1) }

    it do
      expect(subject).to eq(
        {
          service_id: 1,

          owner: false,
          slack: false,

          continuous_integration: false,
          api_documentation: false,
          maintenance_documentation: false
        }
      )
    end
  end

  context 'when service entity is empty' do
    let(:service) { Service.new }

    it { expect(subject).to eq({}) }
  end

  context 'when service entity is different object' do
    [
      nil,
      {},
      [],
      Environment.new
    ].each do |object|
      it { expect(mapper.call(object)).to eq({}) }
    end
  end
end
