# frozen_string_literal: true

RSpec.describe Organisations::Operations::List, type: :operation do
  subject { operation.call(account_id: 1) }

  let(:operation) do
    described_class.new(repo: organisation_repo)
  end

  let(:organisation_repo) do
    instance_double('OrganisationRepository', all_for_account: organisations)
  end

  context 'when account has some organisations' do
    let(:organisations) { [Organisation.new] }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([Organisation.new]) }
  end

  context 'when account has zero organisations' do
    let(:organisations) { [] }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([]) }
  end

  context 'with real dependencies' do
    subject { operation.call(account_id: account.id) }

    let(:account) { Fabricate(:account) }
    let(:organisation) { Fabricate(:organisation) }

    before do
      Fabricate(:account_organisation, account_id: account.id, organisation_id: organisation.id)
    end

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq([organisation]) }
  end
end
