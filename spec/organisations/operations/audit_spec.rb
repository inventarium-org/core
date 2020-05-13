# frozen_string_literal: true

RSpec.describe Organisations::Operations::Audit, type: :operation do
  subject { operation.call(organisation_id: 0, key: 'service', limit: 5) }

  let(:operation) do
    described_class.new(repo: repo)
  end

  let(:repo) do
    instance_double('OrganisationAuditItemRepository', list: [])
  end

  it { expect(subject).to be_success }
  it { expect(subject.value!).to eq([]) }

  context 'with real dependencies' do
    subject { operation.call(organisation_id: organisation.id, key: 'service', limit: 5) }

    let(:operation) { described_class.new }
    let(:organisation) { Fabricate(:organisation) }

    it { expect(subject).to be_success }
  end
end
