# frozen_string_literal: true

RSpec.describe Readiness, type: :entity do
  describe '#completed_checks_count' do
    subject { entity.completed_checks_count }

    context 'when all checks are completed' do
      let(:entity) do
        described_class.new(
          service_id: 1,
          owner: true,
          slack: true,
          continuous_integration: true,
          api_documentation: true,
          maintenance_documentation: true,
          healthcheck: true,
          monitoring: true,
          error_traker: true,
          logs: true
        )
      end

      it { expect(subject).to eq(9) }
    end

    context 'when half of checks are completed' do
      let(:entity) do
        described_class.new(
          service_id: 1,
          owner: true,
          slack: false,
          continuous_integration: true,
          api_documentation: false,
          maintenance_documentation: true,
          healthcheck: false,
          monitoring: true,
          error_traker: false,
          logs: false
        )
      end

      it { expect(subject).to eq(4) }
    end

    context 'when zero checks are completed' do
      let(:entity) { described_class.new }

      it { expect(subject).to eq(0) }
    end
  end
end
