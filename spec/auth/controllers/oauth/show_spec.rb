RSpec.describe Auth::Controllers::Oauth::Show, type: :action do
  let(:action) { described_class.new }
  let(:params) { {} }

  subject { action.call(params) }

  it { expect(subject).to redirect_to '/auth/login' }
end
