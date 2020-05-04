# frozen_string_literal: true

RSpec.describe Services::Operations::Show, type: :operation do
  subject { operation.call(organisation_id: 1, key: 'test-service') }

  let(:operation) do
    described_class.new(repo: service_repo)
  end

  let(:service_repo) do
    instance_double('ServiceRepository', find_for_organisation: service)
  end

  context 'when service exists' do
    let(:service) { Service.new(id: 123) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(service) }
  end

  context "when service does not exist" do
    let(:service) { nil }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:not_found) }
    
  end

  context 'with real dependencies' do
    subject { operation.call(organisation_id: organisation.id, key: 'test-service') }

    let(:operation) { described_class.new }
    let(:organisation) { Fabricate(:organisation) }

    before { Fabricate(:service, organisation_id: organisation.id, key: 'test-service') }

    it { expect(subject).to be_success }
  end
end
