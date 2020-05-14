# frozen_string_literal: true

module Services
  module Operations
    class AllCommunications < ::Libs::Operation
      include Import[
        repo: 'repositories.communication'
      ]

      def call(organisation_id:)
        Success([])
      end
    end
  end
end
