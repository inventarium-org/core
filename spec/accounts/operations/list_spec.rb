# frozen_string_literal: true

RSpec.describe Accounts::Operations::List, type: :operation do
  subject { operation.call(organisation_id: 0) }

  let(:operation) do
    described_class.new(repo: repo)
  end

  let(:repo) do
    instance_double('AccountOrganisationRepository', all_for_organisation: [])
  end

  context 'when repository returns data' do
    it { expect(subject).to be_success }
  end

  context 'with real dependencies' do
    subject { operation.call(organisation_id: organisation.id) }

    let(:operation) { described_class.new }
    let(:organisation) { Fabricate(:organisation) }

    before { Fabricate(:account_organisation, organisation_id: organisation.id) }

    it { expect(subject).to be_success }
  end
end
