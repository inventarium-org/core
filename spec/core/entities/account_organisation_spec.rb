# frozen_string_literal: true

RSpec.describe AccountOrganisation, type: :entity do
  describe '#owner?' do
    subject { member.owner? }

    context 'when organisation member is owber' do
      let(:member) { described_class.new(role: 'owner') }

      it { expect(subject).to be true }
    end

    context 'when organisation member is owber' do
      let(:member) { described_class.new(role: 'participator') }

      it { expect(subject).to be false }
    end
  end
end
