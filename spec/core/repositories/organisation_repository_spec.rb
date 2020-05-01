RSpec.describe OrganisationRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#all_for_account' do
    let(:account) { Fabricate(:account) }
    let(:organisation) { Fabricate(:organisation) }
    let(:empty_account) { Fabricate(:account) }

    before do
      Fabricate(:account_organisation, account_id: account.id, organisation_id: organisation.id)
    end

    context 'when user have organisations' do
      subject { repo.all_for_account(account.id) }

      it { expect(subject).to eq([organisation]) }
    end

    context 'when user does not have any organisations' do
      subject { repo.all_for_account(empty_account.id) }

      it { expect(subject).to eq([]) }
    end
  end

  describe '#find_for_account' do
    let(:account) { Fabricate(:account) }
    let(:organisation) { Fabricate(:organisation) }
    let(:empty_account) { Fabricate(:account) }

    before do
      Fabricate(:account_organisation, account_id: account.id, organisation_id: organisation.id)
    end

    context 'when user have organisations' do
      subject { repo.find_for_account(organisation.slug, account.id) }

      it { expect(subject).to eq(organisation) }
    end

    context 'when user does not have organisations' do
      subject { repo.find_for_account('invalid', account.id) }

      it { expect(subject).to eq(nil) }
    end

    context 'when organisation is not exist' do
      subject { repo.find_for_account(organisation.slug, empty_account.id) }

      it { expect(subject).to eq(nil) }
    end
  end
end
