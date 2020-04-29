# frozen_string_literal: true

RSpec.describe Auth::Controllers::OauthSession::Create, type: :action do
  subject { action.call(params) }

  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it { expect(subject).to redirect_to '/auth/login' }
end
