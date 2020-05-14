# frozen_string_literal: true

RSpec.describe Services::Operations::AllCommunications, type: :operation do
  subject { operation.call(organisation_id: 1) }

  let(:operation) do
    described_class.new(repo: repo)
  end

  let(:repo) do
    instance_double('CommunicationRepository', all_for_organisation: communications)
  end

  context 'when communications exists' do
    let(:communications) { [Communication.new] }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([Communication.new]) }
  end

  context 'when communications does not exist' do
    let(:communications) { [] }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([]) }
  end

  context 'with real dependencies' do
    subject { operation.call(organisation_id: 1) }

    let(:operation) { described_class.new }

    let(:organisation) { Fabricate(:organisation) }

    before do
      service = Fabricate(:service, organisation_id: organisation.id)
      Fabricate(:communication, service_id: service.id)
    end

    it { expect(subject).to be_success }
  end
end
