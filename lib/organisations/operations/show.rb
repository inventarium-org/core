# frozen_string_literal: true

module Organisations
  module Operations
    class Show < ::Libs::Operation
      include Import[
        repo: 'repositories.organisation'
      ]

      def call(slug:, account_id:)
        organisation = repo.find_for_account(slug, account_id)
        organisation ? Success(organisation) : Failure(:not_found)
      end
    end
  end
end
