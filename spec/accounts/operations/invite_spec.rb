# frozen_string_literal: true

RSpec.describe Accounts::Operations::Invite, type: :operation do
  subject { operation.call(organisation_id: 1, payload: payload) }

  let(:operation) do
    described_class.new(
      repo: repo,
      account_organisation_repo: account_organisation_repo
    )
  end

  let(:repo) do
    instance_double('OrganisationInviteRepository', create: OrganisationInvite.new(id: 123))
  end
  let(:account_organisation_repo) do
    instance_double('AccountOrganisationRepository', member?: is_member, invite_account: invite_account)
  end
  let(:payload) { { inviter_id: 1, github_or_email: 'davydovanton' } }
  let(:invite_account) { AccountOrganisation.new(id: 1) }

  context 'when account is a member of organisation' do
    let(:is_member) { true }

    context 'when data is valid' do
      context 'and member exists' do
        let(:invite_account) { AccountOrganisation.new(id: 1) }

        it { expect(subject).to be_success }
        it { expect(subject.value!).to eq(:existed_member_invited) }
      end

      context 'and member does not exist' do
        let(:invite_account) { nil }

        it { expect(subject).to be_success }
        it { expect(subject.value!).to be_a(OrganisationInvite) }

        context 'when data is invalid' do
          before do
            allow(repo).to receive(:create).and_raise(Hanami::Model::UniqueConstraintViolationError)
          end

          it { expect(subject).to be_failure }
          it { expect(subject.failure).to eq(:invalid_data) }
        end
      end
    end
  end

  context 'when account is not a member of organisation' do
    let(:is_member) { false }

    it { expect(subject).to be_failure }
    it { expect(subject.failure).to eq(:account_is_not_a_member_of_organisation) }
  end

  context 'with real dependencies' do
    subject { operation.call(organisation_id: organisation.id, payload: payload) }

    let(:operation) { described_class.new }
    let(:organisation) { Fabricate(:organisation) }
    let(:account_organisation) { Fabricate(:account_organisation, organisation_id: organisation.id) }

    let(:payload) { { inviter_id: account_organisation.account_id, github_or_email: 'davydovanton' } }

    it { expect(subject).to be_success }
  end
end
