# frozen_string_literal: true

module Organisations
  module Operations
    class Audit < ::Libs::Operation
      include Import[
        repo: 'repositories.organisation_audit_item'
      ]

      def call(organisation_id: , key: nil, limit: nil)
        Success(
          repo.list(organisation_id, key: key, limit: limit)
        )
      end
    end
  end
end
