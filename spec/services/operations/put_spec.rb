# frozen_string_literal: true

RSpec.describe Services::Operations::Put, type: :operation do
  subject { operation.call(organisation: Organisation.new, params: params) }

  let(:operation) do
    described_class.new(repo: service_repo, audit_repo: audit_repo)
  end

  let(:service_repo) do
    instance_double('ServiceRepository', create_or_upate: Service.new(id: 123))
  end

  let(:audit_repo) do
    instance_double('OrganisationAuditItemRepository', create: OrganisationAuditItem.new(id: 123))
  end

  let(:params) { Testing::ServiceYamlPayload.generate }

  context 'when data is valid' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(Service.new(id: 123)) }

    it 'spawns sidekiq worker' do
      expect { subject }.to change(Services::Workers::ReadinessCalculator.jobs, :size).by(1)
    end
  end

  context 'when data is invalid' do
    before do
      allow(service_repo).to receive(:create_or_upate).and_raise(Hanami::Model::UniqueConstraintViolationError)
    end

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:invalid_data) }
  end

  context 'with real dependencies' do
    subject { operation.call(organisation: organisation, params: params) }

    let(:operation) { described_class.new }
    let(:organisation) { Fabricate(:organisation) }
    let(:audit_repo) { OrganisationAuditItemRepository.new }

    it { expect(subject).to be_success }
    it { expect { subject }.to change { audit_repo.all.count }.by(1) }
  end
end
