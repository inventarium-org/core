# frozen_string_literal: true

module Organisations
  module Operations
    class List < ::Libs::Operation
      include Import[
        repo: 'repositories.organisation'
      ]

      def call(account_id:)
        Success(repo.all_for_account(account_id))
      end
    end
  end
end
