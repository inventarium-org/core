# frozen_string_literal: true

module Services
  module Operations
    class Show < ::Libs::Operation
      include Import[
        repo: 'repositories.service'
      ]

      def call(organisation_id:, key:)
        service = repo.find_for_organisation(organisation_id, key)
        service ? Success(service) : Failure(:not_found)
      end
    end
  end
end
