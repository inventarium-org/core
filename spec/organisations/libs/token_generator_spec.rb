# frozen_string_literal: true

RSpec.describe Organisations::Libs::TokenGenerator, type: :domain_libs do
  subject { operation.call }

  let(:operation) do
    described_class.new(repo: organisation_repo)
  end

  let(:organisation_repo) do
    instance_double('OrganisationRepository', find_by_token: organisation)
  end

  before do
    allow(SecureRandom).to receive(:alphanumeric).and_return('token1', 'token2')
  end

  context 'when organisation with specific token exists' do
    let(:organisation) { nil }

    before do
      allow(organisation_repo).to receive(:find_by_token).and_return(Organisation.new, nil)
    end

    it { expect(subject).to eq('token2') }
  end

  context 'when organisation with specific token does not exist' do
    let(:organisation) { nil }

    it { expect(subject).to eq('token1') }
  end

  context 'with real dependencies' do
    subject { operation.call }

    let(:operation) { described_class.new }

    it { expect(subject).to eq('token1') }
  end
end
