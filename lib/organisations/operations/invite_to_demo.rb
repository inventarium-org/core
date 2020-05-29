# frozen_string_literal: true

# I created this operation only to invite users to the demo organization.
# Unfortunately I use id value as a magic number but I don't know how to make it better in this case
module Organisations
  module Operations
    class InviteToDemo < ::Libs::Operation
      include Import[
        account_organisation_repo: 'repositories.account_organisation'
      ]

      DEMO_ORGANISATION_ID = 6

      def call(account_id:)
        Success(
          account_organisation_repo.create(organisation_id: DEMO_ORGANISATION_ID, account_id: account_id)
        )
      end
    end
  end
end
