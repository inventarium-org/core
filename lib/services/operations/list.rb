# frozen_string_literal: true

module Services
  module Operations
    class List < ::Libs::Operation
      include Import[
        repo: 'repositories.service'
      ]

      def call(organisation_id:)
        Success(repo.all_for_organisation(organisation_id))
      end
    end
  end
end
