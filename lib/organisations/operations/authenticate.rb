# frozen_string_literal: true

module Organisations
  module Operations
    class Authenticate < ::Libs::Operation
      include Import[
        repo: 'repositories.organisation'
      ]

      def call(token:)
        organisation = repo.find_by_token(token)
        organisation ? Success(organisation) : Failure(:failure_authenticate)
      end
    end
  end
end
