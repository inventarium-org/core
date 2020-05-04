# frozen_string_literal: true

RSpec.describe Organisations::Operations::Authenticate, type: :operation do
  subject { operation.call(token: 'test_token_here') }

  let(:operation) do
    described_class.new(repo: organisation_repo)
  end

  let(:organisation_repo) do
    instance_double('OrganisationRepository', find_by_token: organisation)
  end

  context 'when account has organisation' do
    let(:organisation) { Organisation.new(id: 1) }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to eq(Organisation.new(id: 1)) }
  end

  context 'when account does not have organisation' do
    let(:organisation) { nil }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:failure_authenticate) }
  end

  context 'with real dependencies' do
    subject { operation.call(token: organisation.token) }

    let(:account) { Fabricate(:account) }
    let(:organisation) { Fabricate(:organisation, token: 'test_token_here') }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
