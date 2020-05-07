# frozen_string_literal: true

RSpec.describe AccountOrganisationRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#all_for_organisation' do
    subject { repo.all_for_organisation(organisation_id) }

    let(:organisation) { Fabricate(:organisation) }

    let(:account_organisation) { Fabricate(:account_organisation, organisation_id: organisation.id) }

    before { account_organisation }

    context 'when organisation with accounts exists' do
      let(:organisation_id) { organisation.id }

      it { expect(subject).to eq([account_organisation]) }
    end

    context 'when organisation does not exist' do
      let(:organisation_id) { nil }

      it { expect(subject).to eq([]) }
    end
  end
end
