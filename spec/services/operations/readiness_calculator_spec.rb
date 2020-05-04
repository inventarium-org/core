# frozen_string_literal: true

RSpec.describe Services::Operations::ReadinessCalculator, type: :operation do
  subject { operation.call(service_id: 1) }

  let(:operation) do
    described_class.new(
      service_repo: service_repo,
      readiness_repo: readiness_repo
    )
  end

  let(:service_repo) do
    instance_double('ServiceRepository', find_with_environments: service)
  end

  let(:readiness_repo) do
    instance_double('ReadinesRepository', create: Readiness.new(id: 123))
  end

  let(:params) { Testing::ServiceYamlPayload.generate }

  context 'when service exists' do
    let(:service) { Service.new(id: 321) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Readiness) }
  end

  context 'when service does not exist' do
    let(:service) { nil }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:service_not_found) }
  end

  context 'with real dependencies' do
    subject { operation.call(service_id: service.id) }

    let(:operation) { described_class.new }
    let(:service) { Fabricate(:service) }

    before do
      Fabricate(:environment, service_id: service.id, name: 'production')
    end

    it { expect(subject).to be_success }
  end
end
