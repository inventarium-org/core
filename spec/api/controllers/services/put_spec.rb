# frozen_string_literal: true

RSpec.describe Api::Controllers::Services::Put, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation) }
  let(:operation) { ->(*) { Success(Object.new) } }


  context 'when service.yaml has valid version' do
    let(:params) { { service: service } }
    let(:service) { Testing::ServiceYamlPayload.generate }

    it { expect(subject).to be_success }
  end

  context 'when service.yaml has invalid version' do
    let(:params) { { service: service } }
    let(:service) { { **Testing::ServiceYamlPayload.generate, version: 'v2' } }

    it { expect(subject).to have_http_status(422) }
    it { expect(subject.last).to eq(['Invalid service.yaml file. Please use allowed versions: v0']) }
  end

  context 'when service.yaml is empty' do
    let(:params) { { service: service } }
    let(:service) { {} }

    it { expect(subject).to have_http_status(422) }
    it { expect(subject.last).to eq(['Invalid service.yaml file. Please use allowed versions: v0']) }
  end

  xcontext 'with real dependencies' do
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
