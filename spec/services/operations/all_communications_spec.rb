# frozen_string_literal: true

RSpec.describe Services::Operations::AllCommunications, type: :operation do
  subject { operation.call(organisation_id: 1) }

  let(:operation) do
    described_class.new(repo: repo)
  end

  let(:repo) do
    instance_double('CommunicationRepository')
  end

  it { expect(subject).to be_success }

  context 'with real dependencies' do
    subject { operation.call(organisation_id: 1) }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
