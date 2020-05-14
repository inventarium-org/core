# frozen_string_literal: true

module Services
  module Operations
    class AllCommunications < ::Libs::Operation
      include Import[
        repo: 'repositories.communication'
      ]

      def call(organisation_id:)
        Success(repo.all_for_organisation(organisation_id))
      end
    end
  end
end
