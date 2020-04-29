# frozen_string_literal: true

RSpec.describe Auth::Controllers::Oauth::Show, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new }
  let(:params) { {} }

  it { expect(subject).to redirect_to '/auth/login' }
end
