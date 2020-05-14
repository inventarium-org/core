# frozen_string_literal: true

RSpec.describe CommunicationRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#all_for_organisation' do
    subject { repo.all_for_organisation(organisation_id) }

    let(:organisation) { Fabricate(:organisation, name: 'test communications', slug: 'something') }
    let(:service) { Fabricate(:service, organisation_id: organisation.id) }
    let(:communication) { Fabricate(:communication, service_id: service.id) }

    before do
      communication
      Fabricate(:communication)
    end

    context 'when organisation has some services with communications' do
      let(:organisation_id) { organisation.id }

      it { expect(subject).to eq([communication]) }
    end

    context 'when organisation does not have some services with communications' do
      let(:organisation_id) { nil }

      it { expect(subject).to eq([]) }
    end
  end
  # place your tests here
end
