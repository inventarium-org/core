# frozen_string_literal: true

RSpec.describe Web::Controllers::DemoOrganisationInvites::Create, type: :action do
  subject { action.call(params) }

  let(:invite_operation) { ->(*) { Success(AccountOrganisation.new(id: 0)) } }

  let(:account) { Account.new(id: 1) }
  let(:params) do
    { slug: 'inventarium', 'rack.session' => session }
  end

  let(:action) { described_class.new(invite_operation: invite_operation) }

  context 'when user authenticated' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and invite was successfuly' do
      let(:invite_operation) { ->(*) { Success(AccountOrganisation.new(id: 0)) } }

      it { expect(subject).to redirect_to '/' }

      it 'shows flash message' do
        subject
        expect(action.exposures[:flash][:success]).to eq('User was invited to the demo organisation')
      end
    end

    context 'and invite was not successfuly' do
      let(:invite_operation) { ->(*) { Failure(:something) } }

      it { expect(subject).to redirect_to '/' }

      it 'shows flash message' do
        subject
        expect(action.exposures[:flash][:fail]).to eq("User can't be inited to the demo organisation")
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

    let(:account) { Fabricate(:account) }
    let(:session) { { account: account } }

    let(:new_account) { Fabricate(:account) }

    before { Fabricate(:organisation, id: 6) }

    it do
      expect(subject).to redirect_to '/'
      expect(action.exposures[:flash][:success]).to eq('User was invited to the demo organisation')
    end
  end
end
