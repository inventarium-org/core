# frozen_string_literal: true

Fabricator(:organisation) do
  name 'Inventarium org'
  slug 'inventarium'

  plan 'demo'

  token { SecureRandom.alphanumeric }
end
