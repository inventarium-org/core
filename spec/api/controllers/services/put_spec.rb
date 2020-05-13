# frozen_string_literal: true

RSpec.describe Api::Controllers::Services::Put, type: :action do
  subject { action.call(params) }

  let(:action) do
    described_class.new(
      authenticate_operation: authenticate_operation,
      operation: operation
    )
  end
  let(:operation) { ->(*) { Success(Object.new) } }
  let(:authenticate_operation) { ->(*) { Success(Organisation.new(id: 123)) } }

  context 'when service.yaml has valid version' do
    let(:params) { { service: service, 'HTTP_X_INVENTARIUM_TOKEN' => 'token' } }
    let(:service) { Testing::ServiceYamlPayload.generate }

    context 'and auth token is valid' do
      let(:authenticate_operation) do
        ->(*) { Success(Organisation.new(id: 123, name: 'inventarium_test', plan: 'demo', services: services)) }
      end

      context 'and organisation in demo plan has less than 10 services' do
        let(:services) { 4.times.map { |id| Service.new(id: id, name: "test_#{id}") } }

        context 'and service.yaml data is valid' do
          let(:operation) { ->(*) { Success(Service.new(id: 321)) } }

          it { expect(subject).to be_success }
          it { expect(subject.last).to eq(['OK']) }
        end

        context 'and service.yaml data is invalid' do
          let(:operation) { ->(*) { Failure({ version: ['is missing'], key: ['is missing'] }) } }

          it { expect(subject).to have_http_status(:unprocessable_entity) }
          it { expect(subject.last).to eq(['{"version":["is missing"],"key":["is missing"]}']) }
        end
      end

      context 'and organisation in demo plan has more than 10 services' do
        let(:services) { 14.times.map { |id| Service.new(id: id, name: "test_#{id}") } }

        it { expect(subject).to have_http_status(:forbidden) }
        it { expect(subject.last).to eq(["Organisation has max value of services on 'demo' plan"]) }
      end

      context 'and organisation in demo plan has less than 10 services uniq' do
        let(:services) do
          9.times.map { |i| Service.new(id: i, name: "test_#{i}") } + [Service.new(id: 100, name: 'billing-service')]
        end

        it { expect(subject).to be_success }
        it { expect(subject.last).to eq(['OK']) }
      end
    end

    context 'and auth token is invalid' do
      let(:authenticate_operation) { ->(*) { Failure(:failure_authenticate) } }

      it { expect(subject).to have_http_status(:unauthorized) }
      it { expect(subject.last).to eq(['Authenticate failure, please check your INVENTARIUM_TOKEN EVN value']) }
    end
  end

  context 'when service.yaml has invalid version' do
    let(:params) { { service: service } }
    let(:service) { { **Testing::ServiceYamlPayload.generate, version: 'v2' } }

    it { expect(subject).to have_http_status(:unprocessable_entity) }

    it do
      expect(subject.last).to eq(['Invalid service.yaml file. Please use allowed versions: v0 (Req version: "v2")'])
    end
  end

  context 'when service.yaml is empty' do
    let(:params) { { service: service } }
    let(:service) { {} }

    it { expect(subject).to have_http_status(:unprocessable_entity) }
    it { expect(subject.last).to eq(['Invalid service.yaml file. Please use allowed versions: v0 (Req version: "")']) }
  end

  context 'with real dependencies' do
    subject { action.call(params) }

    let(:action) { described_class.new }

    let(:params) { { service: payload, 'HTTP_X_INVENTARIUM_TOKEN' => 'test_token_here' } }
    let(:payload) { Testing::ServiceYamlPayload.generate }

    before { Fabricate(:organisation, token: 'test_token_here') }

    it { expect(subject).to be_success }
  end
end
