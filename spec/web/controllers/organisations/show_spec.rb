# frozen_string_literal: true

RSpec.describe Web::Controllers::Organisations::Show, type: :action do
  subject { action.call(params) }

  let(:action) do
    described_class.new(
      services_operation: services_operation,
      audit_operation: audit_operation,
      operation: operation
    )
  end
  let(:account) { Account.new(id: 1) }
  let(:params) { { slug: 'inventarium', 'rack.session' => session } }
  let(:services_operation) { ->(*) { Success([Service.new(id: 123)]) } }
  let(:audit_operation) { ->(*) { Success([OrganisationAuditItem.new(id: 123)]) } }

  context 'when user authenticated' do
    let(:session) { { account: Account.new(id: 1) } }

    context 'and operation returns success result' do
      let(:operation) { ->(*) { Success(Organisation.new(id: 123)) } }

      context 'and service services_operation returns success result' do
        let(:services_operation) { ->(*) { Success([Service.new(id: 321)]) } }

        it { expect(subject).to be_success }

        it do
          subject
          expect(action.organisation).to eq(Organisation.new(id: 123))
          expect(action.services).to eq([Service.new(id: 321)])
        end
      end

      context 'and service services_operation returns failure result' do
        let(:services_operation) { ->(*) { Failure(:something) } }

        it { expect(subject).to be_success }

        it do
          subject
          expect(action.organisation).to eq(Organisation.new(id: 123))
          expect(action.services).to eq([])
        end
      end

      context 'and service audit_operation returns success result' do
        let(:audit_operation) { ->(*) { Success([OrganisationAuditItem.new(id: 321)]) } }

        it { expect(subject).to be_success }

        it do
          subject
          expect(action.organisation).to eq(Organisation.new(id: 123))
          expect(action.last_changes).to eq([OrganisationAuditItem.new(id: 321)])
        end
      end

      context 'and service audit_operation returns failure result' do
        let(:audit_operation) { ->(*) { Failure(:something) } }

        it { expect(subject).to be_success }

        it do
          subject
          expect(action.organisation).to eq(Organisation.new(id: 123))
          expect(action.last_changes).to eq([])
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
