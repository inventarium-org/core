# frozen_string_literal: true

module Accounts
  module Operations
    class List < ::Libs::Operation
      include Import[
        repo: 'repositories.account_organisation'
      ]

      def call(organisation_id:)
        Success(repo.all_for_organisation(organisation_id))
      end
    end
  end
end
