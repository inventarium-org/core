# frozen_string_literal: true

RSpec.describe Web::Controllers::Services::Show, type: :action do
  subject { action.call(params) }

  let(:action) do
    described_class.new(
      operation: operation,
      organisation_operation: organisation_operation
    )
  end
  let(:account) { Account.new(id: 1) }
  let(:params) { { slug: 'inventarium', 'rack.session' => session } }
  let(:operation) { ->(*) { Success(Service.new(id: 123)) } }

  context 'when user authenticated' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and organisation_operation returns success result' do
      let(:organisation_operation) { ->(*) { Success(Organisation.new(id: 123)) } }

      context 'and service operation returns success result' do
        let(:operation) { ->(*) { Success(Service.new(id: 321)) } }

        it { expect(subject).to be_success }

        it do
          subject
          expect(action.organisation).to eq(Organisation.new(id: 123))
          expect(action.service).to eq(Service.new(id: 321))
        end
      end

      context 'and service operation returns failure result' do
        let(:operation) { ->(*) { Failure(:something) } }

        it { expect(subject).to redirect_to '/' }
      end
    end

    context 'and organisation_operation returns failure result' do
      let(:organisation_operation) { ->(*) { Failure(:error) } }

      it { expect(subject).to redirect_to '/' }
    end
  end

  context 'when user not authenticated' do
    let(:session) { {} }
    let(:organisation_operation) { ->(*) { Success(Organisation.new(id: 123)) } }

    it { expect(subject).to redirect_to '/auth/login' }
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:account) { Fabricate(:account) }
    let(:session) { { account: account } }
    let(:params) { { slug: 'inventarium', 'rack.session' => session } }

    let(:action) { described_class.new }

    before do
      organisation = Fabricate(:organisation)
      Fabricate(:account_organisation, account_id: account.id, organisation_id: organisation.id)
    end

    it { expect(subject).to be_success }
  end
end
