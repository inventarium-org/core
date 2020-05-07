# frozen_string_literal: true

RSpec.describe Web::Controllers::OrganisationInvites::Create, type: :action do
  subject { action.call(params) }

  let(:action) do
    described_class.new(operation: operation, invite_operation: invite_operation)
  end
  let(:invite_operation) { ->(*) { Success(OrganisationInvite.new(id: 0)) } }

  let(:account) { Account.new(id: 1) }
  let(:params) do
    { slug: 'inventarium', 'rack.session' => session, invite: { inviter_id: account.id, github_or_email: 'test' } }
  end

  context 'when user authenticated' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and operation returns success result' do
      let(:operation) { ->(*) { Success(Organisation.new(id: 123)) } }

      context 'and invite was successfuly' do
        let(:invite_operation) { ->(*) { Success(OrganisationInvite.new(id: 0)) } }

        it { expect(subject).to redirect_to '/inventarium/settings' }

        it 'shows flash message' do
          subject
          expect(action.exposures[:flash][:success]).to eq('User was invited')
        end
      end

      context 'and invite was not successfuly' do
        let(:invite_operation) { ->(*) { Failure(:something) } }

        it { expect(subject).to redirect_to '/inventarium/settings' }

        it 'shows flash message' do
          subject
          expect(action.exposures[:flash][:fail]).to eq("User can't be inited")
        end
      end
    end

    context 'and operation returns failure result' do
      let(:operation) { ->(*) { Failure(:error) } }

      it { expect(subject).to redirect_to '/inventarium/settings' }

      it 'shows flash message' do
        subject
        expect(action.exposures[:flash][:fail]).to eq("User can't be inited")
      end
    end
  end

  context 'when user not authenticated' do
    let(:session) { {} }
    let(:operation) { ->(*) { Success(Organisation.new(id: 123)) } }

    it { expect(subject).to redirect_to '/auth/login' }
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:action) { described_class.new }

    let(:organisation) { Fabricate(:organisation) }
    let(:account) { Fabricate(:account) }
    let(:session) { { account: account } }

    before do
      Fabricate(:account_organisation, account_id: account.id, organisation_id: organisation.id)
    end

    it do
      expect(subject).to redirect_to '/inventarium/settings'
      expect(action.exposures[:flash][:success]).to eq('User was invited')
    end
  end
end
