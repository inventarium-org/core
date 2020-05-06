# frozen_string_literal: true

RSpec.describe Web::Controllers::Organisations::Create, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation) }
  let(:account) { Account.new(id: 1) }
  let(:params) { { organisation: { account_id: account.id, name: 'Inventarium test' }, 'rack.session' => session } }

  context 'when user authenticated' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and operation returns success result' do
      let(:operation) { ->(*) { Success(Organisation.new(id: 123)) } }

      it { expect(subject).to redirect_to '/' }
    end

    context 'and operation returns failure result' do
      let(:operation) { ->(*) { Failure(:error) } }

      it { expect(subject).to redirect_to '/organisations/new' }
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

    it { expect(subject).to redirect_to '/' }
  end
end
