# frozen_string_literal: true

Fabricator(:organisation_invite) do
  organisation_id { Fabricate(:organisation).id }
  inviter_id { Fabricate(:account).id }

  github_or_email 'anton'
end
