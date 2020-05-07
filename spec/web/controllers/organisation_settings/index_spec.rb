# frozen_string_literal: true

RSpec.describe Web::Controllers::OrganisationSettings::Index, type: :action do
  subject { action.call(params) }

  let(:action) do
    described_class.new(operation: operation, account_operation: account_operation)
  end
  let(:account_operation) { ->(*) { Success([]) } }

  let(:account) { Account.new(id: 1) }
  let(:params) { { slug: 'inventarium', 'rack.session' => session } }

  context 'when user authenticated' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and operation returns success result' do
      let(:operation) { ->(*) { Success(Organisation.new(id: 123)) } }

      context 'and account organisation operation returns success result' do
        let(:account_operation) { ->(*) { Success([AccountOrganisation.new(id: 0)]) } }

        it { expect(subject).to be_success }

        it do
          subject
          expect(action.organisation).to eq(Organisation.new(id: 123))
          expect(action.organisation_accounts).to eq([AccountOrganisation.new(id: 0)])
        end
      end

      context 'and account organisation operation returns failure result' do
        let(:account_operation) { ->(*) { Failure(:something) } }

        it { expect(subject).to be_success }

        it do
          subject
          expect(action.organisation).to eq(Organisation.new(id: 123))
          expect(action.organisation_accounts).to eq([])
        end
      end
    end

    context 'and operation returns failure result' do
      let(:operation) { ->(*) { Failure(:error) } }

      it { expect(subject).to redirect_to '/' }
    end
  end

  context 'when user not authenticated' do
    let(:session) { {} }
    let(:operation) { ->(*) { Success(Organisation.new(id: 123)) } }

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
