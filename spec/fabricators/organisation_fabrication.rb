# frozen_string_literal: true

Fabricator(:organisation) do
  name 'Inventarium org'
  slug 'inventarium'

  token { SecureRandom.alphanumeric }
end
