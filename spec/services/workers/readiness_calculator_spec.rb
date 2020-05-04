# frozen_string_literal: true

RSpec.describe Services::Workers::ReadinessCalculator, type: :workers do
  subject { worker.perform(1) }

  let(:worker) { described_class.new(operation: operation, logger: logger, rollbar: rollbar) }
  let(:operation) { instance_double('Services::Operations::ReadinessCalculator', call: result) }
  let(:logger) { double(:logger, info: true, error: true) }
  let(:rollbar) { double(:rollbar, info: true, error: true) }

  context 'when operation returns success value' do
    let(:result) { Success(archived_count: 1) }

    it 'calls logger' do
      expect(logger).to receive(:info)
      subject
    end
  end

  context 'when operation returns failure value' do
    let(:result) { Failure(archived_count: 1) }

    it 'calls rollbar' do
      expect(rollbar).to receive(:error)
      subject
    end
  end

  context 'with real dependencies' do
    subject { worker.perform(service.id) }

    let(:worker) { described_class.new }
    let(:service) { Fabricate.create(:service) }

    it { expect(subject).to be true }
  end
end
