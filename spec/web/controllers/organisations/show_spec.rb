RSpec.describe Web::Controllers::Organisations::Show, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation) }
  let(:account) { Account.new(id: 1) }
  let(:params) { { slug: 'inventarium', 'rack.session' => session } }

  subject { action.call(params) }

  context 'when user authenticated' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and operation returns success result' do
      let(:operation) { ->(*) { Success(Organisation.new(id: 123)) } }

      it { expect(subject).to be_success }
      it do
        subject
        expect(action.organisation).to eq(Organisation.new(id: 123))
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
