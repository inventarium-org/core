# frozen_string_literal: true

RSpec.describe Organisations::Operations::Show, type: :operation do
  subject { operation.call(slug: 'inventarium', account_id: 1) }

  let(:operation) do
    described_class.new(repo: organisation_repo)
  end

  let(:organisation_repo) do
    instance_double('OrganisationRepository', find_for_account: organisation)
  end

  context 'when account has organisation' do
    let(:organisation) { Organisation.new(id: 1) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(Organisation.new(id: 1)) }
  end

  context 'when account does not have organisation' do
    let(:organisation) { nil }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:not_found) }
  end

  context 'with real dependencies' do
    subject { operation.call(slug: organisation.slug, account_id: account.id) }

    let(:account) { Fabricate(:account) }
    let(:organisation) { Fabricate(:organisation) }

    before do
      Fabricate(:account_organisation, account_id: account.id, organisation_id: organisation.id)
    end

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
