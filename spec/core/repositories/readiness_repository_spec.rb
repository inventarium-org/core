# frozen_string_literal: true

RSpec.describe ReadinessRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#create_or_update' do
    subject { repo.create_or_update(service.id, payload) }

    let(:service) { Fabricate(:service) }

    let(:payload) do
      {
        service_id: service.id,
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
    end

    context 'when service has readiness information' do
      before { Fabricate(:readiness, service_id: service.id, owner: false) }

      it { expect { subject }.to change { repo.all.count }.by(0) }
      it { expect(subject.owner).to be(true) }
    end

    context 'when does not have readiness informaion' do
      it { expect { subject }.to change { repo.all.count }.by(1) }
      it { expect(subject.owner).to be(true) }
    end
  end
end
