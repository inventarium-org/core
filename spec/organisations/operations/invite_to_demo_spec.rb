# frozen_string_literal: true

# I use only one call without any validation, that's why I don't want to add any unit tests here
RSpec.describe Organisations::Operations::InviteToDemo, type: :operation do
  subject { operation.call(account_id: account.id) }

  let(:account) { Fabricate(:account) }
  # demo organisation has ID 6 in production DB
  before { Fabricate(:organisation, id: 6) }

  let(:operation) { described_class.new }

  it 'invites user to demo organisation' do
    expect(subject).to be_success
    expect(subject.value!.account_id).to eq(account.id)
    expect(subject.value!.organisation_id).to eq(6)
  end
end
