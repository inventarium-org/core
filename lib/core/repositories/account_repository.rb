# frozen_string_literal: true

class AccountRepository < Hanami::Repository
  associations do
    has_many :auth_identities
  end
end
