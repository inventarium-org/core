# frozen_string_literal: true

RSpec.describe OrganisationAuditItemRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#list' do
    subject { repo.list(organisation.id, key: key, limit: limit) }

    let(:organisation) { Fabricate(:organisation) }

    before do
      repo.create(organisation_id: organisation.id, service_key: 'test-audit', payload: {})
      repo.create(organisation_id: organisation.id, service_key: 'test-audit', payload: {})
      repo.create(organisation_id: organisation.id, service_key: 'test-audit', payload: {})
      repo.create(organisation_id: organisation.id, service_key: 'other-audit', payload: {})
    end

    context 'when key and limit are empty' do
      let(:key) { nil }
      let(:limit) { nil }

      it do
        result = subject
        expect(result).to be_a(Array)
        expect(result.count).to eq(4)
        expect(result).to all(be_a(OrganisationAuditItem))
        expect(result.map(&:organisation_id)).to all(eq(organisation.id))
        expect(result.map(&:service_key).uniq).to eq(%w[other-audit test-audit])
      end
    end

    context 'when key is not empty' do
      let(:key) { 'test-audit' }
      let(:limit) { nil }

      it do
        result = subject
        expect(result).to be_a(Array)
        expect(result.count).to eq(3)
        expect(result).to all(be_a(OrganisationAuditItem))
        expect(result.map(&:organisation_id)).to all(eq(organisation.id))
        expect(result.map(&:service_key).uniq).to eq(['test-audit'])
      end
    end

    context 'when limit is not empty' do
      let(:key) { nil }
      let(:limit) { 2 }

      it do
        result = subject
        expect(result).to be_a(Array)
        expect(result.count).to eq(2)
        expect(result).to all(be_a(OrganisationAuditItem))
        expect(result.map(&:organisation_id)).to all(eq(organisation.id))
        expect(result.map(&:service_key).uniq).to eq(%w[other-audit test-audit])
      end
    end

    context 'when key and limit are not empty' do
      let(:key) { 'test-audit' }
      let(:limit) { 2 }

      it do
        result = subject
        expect(result).to be_a(Array)
        expect(result.count).to eq(2)
        expect(result).to all(be_a(OrganisationAuditItem))
        expect(result.map(&:organisation_id)).to all(eq(organisation.id))
        expect(result.map(&:service_key).uniq).to eq(['test-audit'])
      end
    end

    context 'when key is not exist' do
      let(:key) { 'not-exist' }
      let(:limit) { 2 }

      it { expect(subject).to eq([]) }
    end
  end
end
