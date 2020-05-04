# frozen_string_literal: true

RSpec.describe Services::Operations::List, type: :operation do
  subject { operation.call(organisation_id: 1) }

  let(:operation) do
    described_class.new(repo: service_repo)
  end

  let(:service_repo) do
    instance_double('ServiceRepository', all_for_organisation: [Service.new])
  end

  it { expect(subject).to be_success }

  context 'with real dependencies' do
    subject { operation.call(organisation_id: 1) }

    let(:operation) { described_class.new }
    let(:organisation) { Fabricate(:organisation) }

    before do
      3.times { Fabricate(:service, organisation_id: organisation.id) }
    end

    it { expect(subject).to be_success }
  end
end
