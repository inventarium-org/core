# frozen_string_literal: true

RSpec.describe Organisations::Operations::Create, type: :operation do
  subject { operation.call(name: name, account_id: 0) }

  let(:operation) do
    described_class.new(repo: organisation_repo, token_generator: token_generator)
  end

  let(:token_generator) { -> { 'tokenHere' } }

  let(:organisation_repo) do
    instance_double('OrganisationRepository', create_for_account: Organisation.new)
  end

  context 'when name is valid' do
    let(:name) { 'Inventarium test' }

    it { expect(subject).to be_success }

    it do
      expect(organisation_repo).to receive(:create_for_account).with(
        0, 'Inventarium test', 'inventarium-test', 'tokenHere'
      ).and_return(Organisation.new)

      subject
    end
  end

  context 'when name is invalid' do
    let(:name) { '' }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:invalid_name) }
  end

  context 'with real dependencies' do
    subject { operation.call(name: 'Inventarium test', account_id: account.id) }

    let(:account) { Fabricate(:account) }
    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
