# frozen_string_literal: true

Fabricator(:account_organisation) do
  account_id { Fabricate(:account).id }
  organisation_id { Fabricate(:organisation).id }

  role 'owner'
end
