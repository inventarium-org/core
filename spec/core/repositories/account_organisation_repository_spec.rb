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

  describe '#member?' do
    subject { repo.member?(organisation_id, account_id) }

    let(:organisation) { Fabricate(:organisation) }
    let(:account_organisation) { Fabricate(:account_organisation, organisation_id: organisation.id) }

    context 'when account is a member of organisation' do
      let(:organisation_id) { organisation.id }
      let(:account_id) { account_organisation.account_id }

      it { expect(subject).to be true }
    end

    context 'when account is not a member of organisation' do
      let(:organisation_id) { organisation.id }
      let(:account_id) { 0 }

      it { expect(subject).to be false }
    end

    context 'when organisation does not exist' do
      let(:organisation_id) { 0 }
      let(:account_id) { account_organisation.account_id }

      it { expect(subject).to be false }
    end

    context 'when account is not a member of organisation and organisation does not exist' do
      let(:organisation_id) { 0 }
      let(:account_id) { 0 }

      it { expect(subject).to be false }
    end
  end

  describe '#invite_account' do
    subject { repo.invite_account(organisation.id, 'davydovanton') }

    let(:organisation) { Fabricate(:organisation) }

    context 'when account exists with same github' do
      subject { repo.invite_account(organisation.id, 'davydovanton') }

      before { Fabricate(:auth_identity, login: 'davydovanton') }

      it { expect(subject).to be_a(AccountOrganisation) }
      it { expect { subject }.to change { repo.all.count }.by(1) }
    end

    context 'when account exists with same email' do
      subject { repo.invite_account(organisation.id, 'anton@test.com') }

      before { Fabricate(:account, email: 'anton@test.com') }

      it { expect(subject).to be_a(AccountOrganisation) }
      it { expect { subject }.to change { repo.all.count }.by(1) }
    end

    context 'when account does not exist with same github or email' do
      it { expect(subject).to be nil }

      it { expect { subject }.to change { repo.all.count }.by(0) }
    end
  end

  describe 'inite_new_account' do
    subject { repo.inite_new_account(account.id, email, login) }

    let(:email) { 'anton@test.com' }
    let(:login) { 'anton' }

    let(:account) { Fabricate(:account, email: 'anton@test.com') }
    let(:organisation) { Fabricate(:organisation) }

    before { Fabricate(:auth_identity, account_id: account.id, login: 'anton') }

    context 'when account has zero invites' do
      it { expect { subject }.to change { repo.all.count }.by(0) }
    end

    context 'when account has one invite' do
      before do
        Fabricate(:organisation_invite, organisation_id: organisation.id, github_or_email: 'anton')
      end

      it { expect { subject }.to change { repo.all.count }.by(1) }
    end

    context 'when account has two invites' do
      before do
        Fabricate(:organisation_invite, organisation_id: organisation.id, github_or_email: 'anton')
        Fabricate(:organisation_invite, organisation_id: organisation.id, github_or_email: 'anton@test.com')
      end

      it { expect { subject }.to change { repo.all.count }.by(2) }
    end
  end
end
